# Microservices E-Commerce Platform

A production-grade microservices-based e-commerce application deployed on AWS EKS with automated CI/CD using Jenkins multibranch pipelines.

## Overview

This project implements a complete microservices architecture with 12 independent services. Each service is containerized with Docker, deployed to AWS Elastic Kubernetes Service, and managed through its own automated Jenkins pipeline.

## Architecture

The platform uses a microservices architecture where each service operates independently. Services are deployed as containers on AWS EKS and communicate through Kubernetes service mesh. External traffic is routed through an AWS Application Load Balancer to the Kubernetes cluster.

## Microservices

The platform consists of 12 independent microservices:

**Product Catalog Service** - Manages product information, categories, and pricing  
**Order Service** - Handles order processing and tracking  
**User Service** - Manages user authentication and profiles  
**Payment Service** - Processes payments and transactions  
**Inventory Service** - Tracks stock levels and availability  
**Shopping Cart Service** - Manages user shopping carts  
**Notification Service** - Sends email and SMS notifications  
**Review Service** - Handles product reviews and ratings  
**Shipping Service** - Manages shipping and logistics  
**Analytics Service** - Collects and processes business metrics  
**Search Service** - Provides product search functionality  
**Recommendation Service** - Generates product recommendations

## Technology Stack

**Cloud Platform:** AWS (EKS, ECR, VPC, ALB)  
**Containerization:** Docker  
**Orchestration:** Kubernetes  
**CI/CD:** Jenkins (Multibranch Pipeline)  
**Infrastructure as Code:** Terraform  
**Monitoring:** Prometheus and Grafana

## Key Features

**Independent Service Deployment** - Each service can be deployed independently without affecting others

**Automated CI/CD** - Jenkins multibranch pipelines automatically build and deploy each service

**High Availability** - Multi-AZ deployment with AWS Application Load Balancer

**Scalability** - Kubernetes auto-scaling based on demand

**Zero-Downtime Deployments** - Rolling updates ensure continuous availability

## Repository Structure

The repository uses a multibranch strategy where each microservice has its own branch. The main branch contains the core pipeline configuration and deployment templates. Each service branch includes:

- Service source code
- Dockerfile
- Jenkinsfile for automated deployment
- Service-specific configuration

## CI/CD Implementation

Each of the 12 microservices has its own Jenkins multibranch pipeline. When code is pushed to a service branch, Jenkins automatically:

- Builds the Docker image for that service
- Runs automated tests
- Pushes the image to the container registry
- Deploys the updated service to AWS EKS

This allows independent development and deployment of each service without coordinating releases.

## Deployment

The application runs on AWS EKS with services deployed across multiple availability zones. Kubernetes manages container orchestration, scaling, and health monitoring. The AWS Application Load Balancer distributes incoming traffic across service instances.

## Getting Started

### Prerequisites

- AWS account with EKS access
- kubectl configured for your cluster
- Docker installed locally
- Jenkins server with multibranch pipeline support

### Deployment

Clone the repository:
```
git clone https://github.com/hammad558/Microservices-Ecommerce-Project.git
```

Deploy to Kubernetes:
```
kubectl apply -f deployment-service.yml
```

Verify deployment:
```
kubectl get pods
kubectl get services
```

### Jenkins Setup

Configure Jenkins multibranch pipeline pointing to this repository. Jenkins will automatically discover all 12 service branches and create individual pipelines for each.

## Monitoring

The platform uses Prometheus for metrics collection and Grafana for visualization. This provides visibility into service health, performance, and resource utilization across the entire platform.

## Security

- Secrets managed through Kubernetes Secrets and AWS Secrets Manager
- Container image scanning before deployment
- Network policies for service isolation
- IAM roles for AWS resource access

## Future Enhancements

- Service mesh implementation (Istio/Linkerd)
- Distributed tracing across services
- Canary deployment strategy
- Multi-region deployment
- Enhanced observability and logging

## Author

**Hammad Khalid**  
DevOps Engineer | AWS, Kubernetes, CI/CD Automation

GitHub: https://github.com/hammad558  
LinkedIn: https://linkedin.com/in/hammad-khalid99  



