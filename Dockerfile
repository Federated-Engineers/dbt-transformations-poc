# Official Python runtime image
FROM python:3.12-slim 

# setting container working directory
ENV WORKDIR /dbt_poc_dir
RUN mkdir -p $WORKDIR
WORKDIR $WORKDIR

# install necessary linux packages 
RUN apt-get update && apt-get install -y \
  git-all \
  curl \
  unzip
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf awscliv2.zip

# copy over python dependencies file
COPY ./requirements.txt .
# install python dependencies
RUN pip install -r requirements.txt

# copy the dbt project and scripts folder into container
COPY dbt_poc_dir dbt_poc_dir
COPY scripts scripts

# add execute permissions to the entrypoint script
RUN chmod +x scripts/run_dbt.sh

ENTRYPOINT [ "/bin/sh", "-c"]
CMD ["scripts/run_dbt.sh"]
