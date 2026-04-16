#!/bin/bash

# Firebase Credentials Setup Script
# Run this after setting up your Firebase project

echo "=== Firebase Credentials Setup ==="
echo ""
echo "1. Go to: https://console.firebase.google.com"
echo "2. Select your project 'holics-app'"
echo "3. Click Settings (gear icon) → Project Settings"
echo "4. Go to 'General' tab"
echo ""
echo "Copy these values and update .env file:"
echo ""
echo "  FIREBASE_PROJECT_ID = Project ID"
echo "  FIREBASE_MESSAGING_SENDER_ID = Sender ID"
echo ""
echo "5. Go to 'Service Accounts' tab"
echo "6. Select 'Node.js' and click 'Generate New Private Key'"
echo "7. Copy the JSON, get these values:"
echo ""
echo "  FIREBASE_API_KEY = Your API Key (from SDK setup)"
echo "  FIREBASE_APP_ID = Your App ID"
echo ""
echo "=== Then run: ==="
echo "firebase deploy"
echo ""
