# Whiteivyson-hosting3-for-3-application
3-Tier Architecture Application
This repository contains the infrastructure and application code for a scalable 3-tier architecture deployed on AWS. The application is designed to ensure high availability, security, and efficient handling of web requests through a single endpoint provided by the Application Load Balancer (ALB) DNS.

Architecture Overview
Components
Presentation Layer (Web Tier):

Two web servers deployed in a public subnet.
Handles user requests and serves the frontend application.
Application Layer (Application Tier):

Manages business logic and connects the web servers to the database.
Deployed on the web servers.
Data Layer (Database Tier):

A single database instance hosted in a private subnet.
Provides data persistence and management, ensuring secure access.
Single Endpoint
Load Balancer:
An AWS Application Load Balancer (ALB) is used to route incoming traffic.
All external requests are directed to the ALB DNS, which then distributes the traffic to the web servers.
