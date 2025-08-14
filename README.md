# WhatsApp Clone

A real-time messaging application built with Ruby on Rails, featuring user authentication and WebSocket-powered messaging using Action Cable.

## Features

- **User Authentication**: Sign up and login with username and password
- **Real-time Messaging**: Send and receive messages instantly using Action Cable (WebSockets)
- **Message History**: All messages are persisted in the database
- **Modern UI**: Beautiful, responsive interface built with Tailwind CSS
- **User Management**: See all available users and chat with them

## Prerequisites

- Ruby 3.2+
- PostgreSQL
- Node.js and Yarn (for asset building)

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd whatsapp_clone
```

2. Install Ruby dependencies:
```bash
bundle install
```

3. Install JavaScript dependencies:
```bash
yarn install
```

4. Set up the database:
```bash
rails db:create
rails db:migrate
rails db:seed
```

5. Build the assets:
```bash
yarn build
yarn build:css
```

6. Start the server:
```bash
rails server
```

The application will be available at `http://localhost:3000`

## Usage

### Test Users

The application comes with pre-created test users:
- **alice** (password: password123)
- **bob** (password: password123)
- **charlie** (password: password123)
- **diana** (password: password123)

### Getting Started

1. Visit `http://localhost:3000`
2. Sign up for a new account or login with existing credentials
3. Select a user from the sidebar to start chatting
4. Type your message and press Enter or click Send
5. Messages will appear in real-time for both users

## Development

### Running in Development Mode

Use the development server with asset watching:
```bash
bin/dev
```

This will start:
- Rails server
- JavaScript build process (with watch)
- CSS build process (with watch)

### Database

The application uses PostgreSQL with the following models:
- **User**: Stores user accounts with username and encrypted password
- **Message**: Stores messages with sender, recipient, and content

### Real-time Messaging

Real-time messaging is powered by Action Cable (WebSockets):
- Messages are broadcast to specific chat rooms
- Each chat room is identified by the sorted user IDs
- Messages are persisted in the database for history

## Technology Stack

- **Backend**: Ruby on Rails 8.0
- **Database**: PostgreSQL
- **Authentication**: bcrypt for password hashing
- **Real-time**: Action Cable (WebSockets)
- **Frontend**: Tailwind CSS, Stimulus.js
- **Asset Pipeline**: jsbundling-rails, cssbundling-rails, esbuild

## License

This project is open source and available under the [MIT License](LICENSE).
