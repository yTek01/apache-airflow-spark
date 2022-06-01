import requests
import json
from pyspark.sql import SparkSession
from pyspark import SQLContext
from pyspark.sql import functions as F
from decouple import config

aws_access_key = config('AWS_ACCESS_KEY')
aws_secret_key = config('AWS_SECRET_KEY')

spark = SparkSession \
    .builder \
    .appName("DataExtraction") \
    .getOrCreate()

hadoop_conf = spark.sparkContext._jsc.hadoopConfiguration()
hadoop_conf.set("fs.s3a.access.key", aws_access_key)
hadoop_conf.set("fs.s3a.secret.key", aws_secret_key)
hadoop_conf.set("fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem")

response = requests.get("https://api.mfapi.in/mf/118550")
data = response.json()
json_formatted = json.dumps(data)
with open("./api_data.json", "w") as data_file:
        data_file.write(json_formatted)

        raw_json_dataframe = spark.read.format("json") \
                                .option("inferSchema","true") \
                                .load("./api_data.json")

raw_json_dataframe.printSchema()
raw_json_dataframe.createOrReplaceTempView("Mutual_benefit")

dataframe = raw_json_dataframe.withColumn("data", F.explode(F.col("data"))) \
        .withColumn('meta', F.expr("meta")) \
        .select("data.*", "meta.*")
        
dataframe.show(100, False)
dataframe.write.format('csv').option('header','true').save('s3a://sparkjobresult/output',mode='overwrite')