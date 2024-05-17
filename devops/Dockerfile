FROM amazon/aws-cli:latest

RUN mkdir -p /root/.aws

COPY config /root/.aws/config
COPY credentials /root/.aws/credentials

ENV TERRAFORM_VERSION=1.0.11

RUN yum install -y yum-utils \
    && yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo \
    && yum -y install terraform-${TERRAFORM_VERSION}

WORKDIR /root

CMD ["bash"]