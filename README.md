# SkillSwap BE

SkillShare BE is the backend application built with Vapor for the SkillShare project. It handles user authentication, profile management, and serves as the API for the SkillShare mobile app.

# Overview
This repository contains the backend services for SkillShare, built using Vapor, a Swift-based server-side framework. The backend currently supports:

User authentication (signup, login)

User profile management

API endpoints to be consumed by the SkillShare mobile app

More to be developed this is in the first phase now.
# Architecture
Vapor framework with Swift

RESTful API design

PostgreSQL (or your database of choice) for data storage

Deployed on Render.com for cloud hosting

# Features
User Authentication: Secure signup, login, password hashing, and session/token management.

User Profile: Manage user profile information and update endpoints.

Scalable API: Designed to extend with new modules and services.

# Running Locally

git clone https://github.com/SreekuttyM/SkillSwap.git

cd SkillShareBE

Configure your database connection in configure.swift or via environment variables.

vapor run migrate

vapor run serve

The server runs by default on http://localhost:8080

# Deployment

The backend is deployed on Render.com. The service automatically builds and deploys on git pushes.
http://0.0.0.0:8085

# API Documentation

POST /auth/signup 

POST /auth/signin

POST /auth/refresh

GET /profile

PUT /profile
