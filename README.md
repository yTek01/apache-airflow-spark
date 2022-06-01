# apache-airflow-spark

Here in this repository, we have designed a simple ETL process that extract data from an API and we are transforming this data using Spark and loading this data into an AWS S3 bucket. We running this batch processes using Airflow by Spark job submit Operator in Airflow. 

We are using the API data provided by [Indian Mutual Fund API](https://www.mfapi.in/), you can read more about the API online to learn more about it. The focus of this repository is Spark and Airflow. 

## Things to do;

*  Set up Apache Spark locally. 
*  Set up Apache Airflow on locally.
*  Write the Spark Jobs to Extract, Transform and Load the data. 
*  Design the Airflow DAG to trigger and schedule the Spark jobs.

## Set up Apache Spark locally
```bash
bash scripts/spark_installation.sh
```

```
source ~/.bashrc \
start-master.sh 
```

```
start-slave.sh spark://XXXXXXXXXXXX:7077
```
## Set up Apache Airflow on locally
```bash
bash scripts/airflow_installer.sh
```
## Run the Spark job to see if everything works on the Spark side
```bash
spark-submit --master spark://XXXXXXXXXXXX:7077 spark_etl_script.py
```

* If everything works as expected on the Spark side, now create the Airflow dags folder in AIRFLOW_HOME
```bash
mkdir ~/airflow/dags
```

* Move the Spark job DAG file to the Airflow dags folder
```bash
mv dags/spark_jobs_dag.py ~/airflow/dags
```

* Go to http://localhost:8080/ to access the Airflow UI
