# RaceDay – South African Road Events Management System

## Project Overview

RaceDay is a full-stack web-based event management system designed for the South African road running, walking, and cycling community. It allows Event Organisers to create and manage events, categories, and participant results, while Participants can browse events, enter races, track their performance history, and prepare for race day.

This repository contains the **Part 1** submission: system planning and database design. No application code is included yet.

## User Roles

1. **Organiser**  
   - Create, edit, and delete events.  
   - Manage event categories (distances, fees, limits).  
   - View all enrolments for their events.  
   - Capture and manage participant results.

2. **Participant**  
   - Create an account and manage their profile.  
   - Browse and search for upcoming events.  
   - Enrol in an event by selecting a category.  
   - View their own enrolments and personal results.  
   - Make payments for entry fees.


## Repository Structure
├── .github/
│ └── workflows/
│ └── validate.yml workflow for Part 1
├── docs/
│ ├── ERD.pdf # Entity Relationship Diagram 
│ ├── API-Endpoints.md # API endpoint plan
│ └── RaceDay.sql # SQL database script
└── README.md


## CI/CD Status

[CI/CD Green Build]

## Video Presentation

Part 1 YouTube Walkthrough

## Setup Instructions (for reviewing Part 1)

 Clone the repository:
   ```bash
   git clone https://github.com/B-mogane/ST100493210_POG_POE_PART1
   cd raceday