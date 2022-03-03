{{
  config(
    materialized = 'view',
    schema= 'cfb'
  )
}}

select

school

from {{ref('cfb_teams')}}