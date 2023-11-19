# README

## About

## Images

## Configuration

## Permissions
The access control list is based on the current_role on the logged in user.

Users with role "admin" can:
- CRUD projects
  - except delete projects with child projects, returns 302
- CRUD environments
- CRUD secrets
- CRUD api users
- CRUD users
  - except delete their own user, returns 409

Users with role "user" can:
- CRUD projects
  - except delete projects with child projects, returns 302
- CRUD environments
- CRUD secrets
- List api users

Api Users automatically receive the role "admin".

## projectdbctl

# TODO
- update docs with screenshot and logo
- dashboard
- resource milestones
- gantt chart (project GET)
