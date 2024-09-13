FROM node:20.17-bookworm-slim

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
    curl \
    build-essential \
    gnupg \
    apt-transport-https \
    ca-certificates \
    unzip \
    git && \
    npm install -g npm@10.8.3 

RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg \
    && chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg \
    && echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list \
    && chmod 644 /etc/apt/sources.list.d/kubernetes.list && apt-get update && apt-get install -y kubectl 

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update

RUN curl -fsSL https://get.pulumi.com | sh
ENV PATH="$PATH:/root/.pulumi/bin"

WORKDIR /pulumi/projects

COPY package*.json .
RUN npm ci

COPY Pulumi.* .
COPY index.ts .
COPY pulumi.sh .
RUN chmod +x ./pulumi.sh

# CMD [ "./pulumi.sh" ] 
CMD [ "pulumi", "up", "-f", "-s", "demo/dev" ]