
import dash
import dash_html_components as html
import plotly.graph_objects as go
import dash_core_components as dcc
import plotly.express as px
from dash.dependencies import Input, Output
import pandas as pd
from sqlalchemy import create_engine


app = dash.Dash()


def postgres_database_connection():
    """Returns the DB engine"""
    try:
        print('Connecting to DB')
        conn =  "postgresql+psycopg2://rworrell:1998HondaCRV@postgresq.cluster-catsuvgqqq1n.us-east-1.rds.amazonaws.com:5432/postgres" 
        engine = create_engine(conn)
        print('Connected to DB')
        return engine
    except Exception as e:
        print (e)

### INITIALIZE ENGINE ###
engine = postgres_database_connection()
df = pd.read_sql_query('select * from cfb.VT_Game_History', engine)
print(df)



def hokie_games():
    # Function for creating line chart showing Google stock prices over time 
    fig = go.Figure([go.Scatter(x = df['start_date'], y = df['points'],\
                     line = dict(color = 'firebrick', width = 4), name = 'Google')
                     ])
    fig.update_layout(title = 'Hokie Game Scores Over Time',
                      xaxis_title = 'Dates',
                      yaxis_title = 'Points'
                      )
    return fig  

 
app.layout = html.Div(id = 'parent', children = [
    html.H1(id = 'H1', children = 'Styling using html components', style = {'textAlign':'center',\
                                            'marginTop':40,'marginBottom':40}),

        
        dcc.Graph(id = 'line_plot', figure = hokie_games())    
    ]
                     )

if __name__ == '__main__': 
    app.run_server()
