# Service Project

[![Status](https://img.shields.io/badge/status-in%20development-yellow.svg)](https://github.com/tuuser/service-project)
[![Terraform](https://img.shields.io/badge/terraform-1.x-844FBA)](https://www.terraform.io/)
[![Traefik](https://img.shields.io/badge/traefik-2.x-brightgreen)](https://traefik.io/)
[![Umami](https://img.shields.io/badge/analytics-umami-blue)](https://umami.is/)
[![Jenkins](https://img.shields.io/badge/jenkins-in%20development-orange)](https://jenkins.io/)

## 📋 Description

Service-Project is a set of technologies for hosting and managing multiple web services. The project uses AWS as the main cloud provider and is built following infrastructure as code (IaC) best practices.

### 🎯 Purpose
- **Personal Services**: Hosting personal projects such as web portfolio, personal blog, and development tools.
- **Client Projects**: Hosting websites and applications developed for third parties.
- **Productive Tools**: Deployment of useful services such as analytics, monitoring, and management tools.

## 🏗️ Architecture

- **Cloud Infrastructure (AWS)**
  - EC2 for main services
  - Docker for containers
  - RDS for databases
  - VPC configured with public and private subnets
  - Route53 for DNS management
  - Pritunl VPN for remote access

- **Reverse Proxy (Traefik)**
  - Automatic SSL certificate management
  - Microservices routing
  - Load balancing
  - Service monitoring

- **Analytics (Umami)**
  - Web traffic analysis
  - User metrics
  - Conversion tracking
  - Custom reporting

## 🚀 Main Features

- **Service Portal**
  - Web application deployment
  - Personal portfolio hosting
  - Personal tools hosting
  - Third-party project management

- **Deployed Services**
  - Professional portfolios
  - Custom web applications
  - Development tools
  - Open source projects
  - Demos and prototypes

- **Technical Features**
  - Automated deployment with Terraform
  - Intelligent routing with Traefik
  - Traffic analysis through Umami
  - Automatic backups

## 💻 Tech Stack

- **Database**: PostgreSQL
- **IaC**: Terraform
- **Proxy**: Traefik
- **Analytics**: Umami
- **Containers**: Docker
- **CI/CD**: Jenkins (in development)

## 🔄 CI/CD Pipeline (In Development)

Currently implementing a continuous integration and deployment pipeline using Jenkins, which will include:

- **Phase 1** (In Development):
  - GitHub integration
  - Automated testing
  - Static code analysis
  - Vulnerability scanning
  - Docker image building

- **Phase 2** (Planned):
  - Automated staging deployment
  - Integration testing
  - Production deployment
  - Automatic notifications

> ⚠️ **Note**: The CI/CD pipeline is currently under development and not fully operational. At present, deployments are performed manually following documented procedures.