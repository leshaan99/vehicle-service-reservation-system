# Vehicle Service Reservation System

This is a secure web application designed for vehicle service reservations. The application allows users to manage their service reservations while ensuring compliance with security best practices by mitigating OWASP Top 10 vulnerabilities.

## Features

- **User Authentication**: Utilizes OIDC (OpenID Connect) for secure user authentication with a cloud-based Identity Provider (IDP).
- **User Profile**: Displays user profile information, including username, name, email, contact number, and country.
- **Service Reservation Management**:
  - Create new vehicle service reservations with details such as date, time, location, vehicle registration number, mileage, and a message.
  - View a list of past and upcoming reservations.
  - Delete upcoming reservations.
- **Secure Access Control**: Ensures users can only access and modify their own reservation information.

## Technology Stack

- **Frontend**: React.js
- **Backend**: Node.js with Express
- **Database**: MongoDB (or MySQL if preferred)
- **Authentication**: OIDC (using [Your Chosen IDP, e.g., Auth0])
- **Deployment**: Docker

## Security Considerations

This application has been developed with a strong focus on security, implementing measures to prevent common vulnerabilities, including SQL Injection, XSS, CSRF, and authentication bypass.

## Blog Post

For an overview of the development process, security measures considered, and challenges faced, check out my blog post
