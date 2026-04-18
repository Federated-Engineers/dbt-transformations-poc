# Official Python runtime image
FROM python:3.12-slim 

WORKDIR dbt_poc_dir
# copy the dbt project and scripts folder into container
ADD dbt_poc_dir /dbt_poc_dir


# copy over python dependencies file
COPY ./requirements.txt .

# install python dependencies
RUN pip install -r requirements.txt

# add execute permissions to the entrypoint script
RUN chmod -R 755 /dbt_poc_dir/run_dbt.sh

ENTRYPOINT [ "/bin/sh", "-c"]
CMD ["./run_dbt.sh"]
