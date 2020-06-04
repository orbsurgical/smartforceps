import dash
import dash_table
import dash_core_components as dcc
import dash_html_components as html
import plotly.graph_objs as go
from dash.dependencies import State, Input, Output
from dash.exceptions import PreventUpdate

import pandas as pd
import os
import warnings

warnings.simplefilter(action='ignore', category=FutureWarning)

dash_app = dash.Dash(
    __name__,
    meta_tags=[
        {
            "name": "viewport",
            "content": "width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no",
        }
    ],
)
app = dash_app.server

dash_app.config["suppress_callback_exceptions"] = True

# Load data
df_feature = pd.read_csv("data/SmartForcepsDataFeature.csv")
df_processed = pd.read_csv("data/SmartForcepsDataProcessed.csv")
force_labels = pd.DataFrame({'feature': ['DurationForce',
                                         'MeanForce',
                                         'MaxForce',
                                         'MinForce',
                                         'RangeForce',
                                         'ForcePeaks',
                                         'DForceSD',
                                         'nPeriod',
                                         'Frequency',
                                         'PeriodLn',
                                         'Trend',
                                         'FluctAnal',
                                         'Linearity',
                                         'Stability',
                                         'Lumpiness',
                                         'Curvature',
                                         'Entropy',
                                         'AutocorrFuncE1',
                                         'AutocorrFuncE10'],
                             'title': ['Distribution of Force Application Duration',
                                       'Distribution of Force Mean',
                                       'Distribution of Force Max',
                                       'Distribution of Force Min',
                                       'Distribution of Force Range',
                                       'Distribution of the Average of Force Peaks',
                                       'Distribution of Standard Deviation for the First Derivative of the '
                                       'Force Signal',
                                       'Distribution of the Number of Force Peaks',
                                       'Distribution of Dominant Time-series Harmonics form FFT',
                                       'Distribution of the Average Length of Force Cycles',
                                       'Distribution of Force Signal Trend',
                                       'Distribution of Force Signal Fluctuation Index',
                                       'Distribution of Force Signal Linearity Index',
                                       'Distribution of Force Signal Stability Index',
                                       'Distribution of Force Signal Lumpiness Index',
                                       'Distribution of Force Signal Curvature Index',
                                       'Distribution of Force Signal Entropy Index',
                                       'Distribution of First Autocorrelation Coefficient in Force Signal',
                                       'Distribution of Sum of the First 10 Squared Autocorrelation '
                                       'Coefficient in Force Signal'],
                             'x_title': ['Duration (sec)',
                                         'Force (N)',
                                         'Force (N)',
                                         'Force (N)',
                                         'Force (N)',
                                         'Force (N)',
                                         'Standard Deviation of the First Derivative of Force',
                                         'Number of Force Peaks',
                                         'Frequency (Hz)',
                                         'Cycle Length (sec)',
                                         'Trend',
                                         'Fluctuation Index',
                                         'Linearity Index',
                                         'Stability Index',
                                         'Lumpiness Index',
                                         'Curvature Index',
                                         'Entropy Index',
                                         'Autocorrelation Coefficient',
                                         'Autocorrelation Coefficient']})

# Plotly mapbox token
mapbox_access_token = "pk.eyJ1IjoiYW1pcmJhZ2hkYWRpIiwiYSI6ImNrYW9wMTgyOTB3aWwyd3J4YTF0ZWJsbHAifQ.wjNU_8ylyfwKMjZuBddwXg"

country_map = {
    "Canada": "Canada",
    "US": "United States",
    "Germany": "Germany",
    "China": "China",
    "India": "India",
}

country_list = list(country_map.keys())

# Load data
data_dict = {}
for country in country_list:
    p = os.getcwd().split(os.path.sep)
    csv_path = "data/centers/df_{}_lat_lon.csv".format(country)
    country_data = pd.read_csv(csv_path)
    data_dict[country] = country_data

init_region = data_dict[country_list[1]][
    "Hospital Province"
].unique()

def generate_aggregation(df):
    aggregation = {
        "Number of Surgeons": ["mean", "sum"],
        "Number of SmartForceps": ["mean", "sum"],
        "Number of Cases": ["mean", "sum"],
    }
    grouped = (
        df.groupby(["Hospital Province", "Hospital Name"])
            .agg(aggregation)
            .reset_index()
    )

    grouped["lat"] = grouped["lon"] = grouped["Hospital Street Address"] = grouped[
        "Hospital Name"
    ]
    grouped["lat"] = grouped["lat"].apply(lambda x: get_lat_lon_add(df, x)[0])
    grouped["lon"] = grouped["lon"].apply(lambda x: get_lat_lon_add(df, x)[1])
    grouped["Hospital Street Address"] = grouped["Hospital Street Address"].apply(
        lambda x: get_lat_lon_add(df, x)[2]
    )

    return grouped


def get_lat_lon_add(df, name):
    return [
        df.groupby(["Hospital Name"]).get_group(name)["lat"].tolist()[0],
        df.groupby(["Hospital Name"]).get_group(name)["lon"].tolist()[0],
        df.groupby(["Hospital Name"])
            .get_group(name)["Hospital Street Address"]
            .tolist()[0],
    ]


def gen_distribution_plot(df, feature):
    figure = go.Figure()
    figure.add_trace(go.Violin(
        x=df['Value'][df['User'] == 'Expert'],
        y=df['TaskType'][df['User'] == 'Expert'],
        customdata=df['SegmentNumOverall'][df['User'] == 'Expert'],
        legendgroup='Expert',
        scalegroup='Expert',
        name='Expert',
        side='positive',
        line_color='lightseagreen',
        marker=dict(
            line=dict(
                width=1,
                color='lightseagreen'
            ),
            symbol='line-ns'),
        orientation='h',
        points='all',
        box=dict(visible=True),
        meanline=dict(visible=True)
    ))
    figure.add_trace(go.Violin(
        x=df['Value'][df['User'] == 'Novice'],
        y=df['TaskType'][df['User'] == 'Novice'],
        customdata=df['SegmentNumOverall'][df['User'] == 'Novice'],
        legendgroup='Novice',
        scalegroup='Novice',
        name='Novice',
        side='negative',
        line_color='mediumpurple',
        marker=dict(
            line=dict(
                width=1,
                color='mediumpurple'
            ),
            symbol='line-ns'),
        orientation='h',
        points='all',
        box=dict(visible=True),
        meanline=dict(visible=True)
    ))
    figure.update_layout(
        title=force_labels['title'][force_labels['feature'] == feature].to_numpy()[0],
        margin=dict(t=50, b=10, l=50, r=50),
        hovermode='closest',
        xaxis=dict(
            zeroline=False,
            automargin=True,
            showticklabels=True,
            title=dict(text=force_labels['x_title'][force_labels['feature'] == feature].to_numpy()[0],
                       font=dict(color="#737a8d")),
            linecolor="#737a8d",
            showgrid=False
        ),
        yaxis=dict(
            zeroline=False,
            automargin=True,
            showticklabels=True,
            title=dict(text='Task Type',
                       font=dict(color="#737a8d")),
            linecolor="#737a8d",
            showgrid=False
        ),
        font=dict(color="#737a8d"),
        plot_bgcolor="#171b26",
        paper_bgcolor="#171b26",
    )

    return figure


def gen_timeseries(df_r, df_l):
    figure = go.Figure()
    figure.add_trace(go.Scatter(
        x=df_r.Time,
        y=df_r.Value,
        name='Right Prong',
        line=dict(color="rgb(8,81,156)")
    ))
    figure.add_trace(go.Scatter(
        x=df_l.Time,
        y=df_l.Value,
        name='Left Prong',
        line=dict(color="rgb(255,64,64)")
    ))
    figure.update_layout(
        title='Force Time Series of Selected Task Cycle',
        xaxis_title='Time (sec)',
        yaxis_title='Force (N)',
        font=dict(
            color="#737a8d"
        ),
        height=300,
        margin=dict(
            t=50,
            b=10,
            l=50,
            r=50
        ),
        xaxis=dict(
            zeroline=False,
            automargin=True,
            showticklabels=True,
            title=dict(text='Time (sec)',
                       font=dict(color="#737a8d")),
            tickfont=dict(color="#737a8d"),
            linecolor="#737a8d",
            showgrid=False
        ),
        yaxis=dict(
            zeroline=False,
            automargin=True,
            showticklabels=True,
            title=dict(text='Force (N)',
                       font=dict(color="#737a8d")),
            tickfont=dict(color="#737a8d"),
            linecolor="#737a8d",
            showgrid=False
        ),
        plot_bgcolor='#171b26',
        paper_bgcolor='#171b26'
    )

    return figure

def generate_geo_map(geo_data, region_select):
    filtered_data = geo_data[
        geo_data["Hospital Province"].isin(region_select)
    ]

    colors = ["rgb(256,256,256)", "rgb(57,105,172)"]

    hospitals = []

    lat = filtered_data["lat"].tolist()
    lon = filtered_data["lon"].tolist()
    number_of_cases_mean = filtered_data["Number of Cases"]["mean"].tolist()
    regions = filtered_data["Hospital Province"].tolist()
    hospital_name = filtered_data["Hospital Name"].tolist()

    case_metric_data = {}
    case_metric_data["min"] = filtered_data["Number of Cases"]["mean"].min()
    case_metric_data["max"] = filtered_data["Number of Cases"]["mean"].max()
    case_metric_data["mid"] = (case_metric_data["min"] + case_metric_data["max"]) / 2
    case_metric_data["low_mid"] = (
                                          case_metric_data["min"] + case_metric_data["mid"]
                                  ) / 2
    case_metric_data["high_mid"] = (
                                           case_metric_data["mid"] + case_metric_data["max"]
                                   ) / 2

    for i in range(len(lat)):
        val = number_of_cases_mean[i]
        region = regions[i]
        provider = hospital_name[i]

        if val <= case_metric_data["low_mid"]:
            color = colors[0]
        elif case_metric_data["low_mid"] < val <= case_metric_data["mid"]:
            color = colors[0]
        elif case_metric_data["mid"] < val <= case_metric_data["high_mid"]:
            color = colors[1]
        else:
            color = colors[1]

        selected_index = []

        hospital = go.Scattermapbox(
            lat=[lat[i]],
            lon=[lon[i]],
            mode="markers",
            marker=dict(
                color=color,
                showscale=True,
                colorscale=[
                    [0, "rgb(256,256,256)"],
                    [1, "rgb(57,105,172)"],
                ],
                cmin=case_metric_data["min"],
                cmax=case_metric_data["max"],
                size=10
                     * (1 + (val + case_metric_data["min"]) / case_metric_data["mid"]),
                colorbar=dict(
                    x=0.9,
                    len=0.7,
                    title=dict(
                        text="SmartForceps Cases",
                        font={"color": "#737a8d", "family": "Open Sans"},
                    ),
                    titleside="top",
                    tickmode="array",
                    tickvals=[case_metric_data["min"], case_metric_data["max"]],
                    ticktext=[
                        "{:,.0f}".format(case_metric_data["min"]),
                        "{:,.0f}".format(case_metric_data["max"]),
                    ],
                    ticks="outside",
                    thickness=15,
                    tickfont={"family": "Open Sans", "color": "#737a8d"},
                ),
            ),
            opacity=0.8,
            selectedpoints=selected_index,
            selected=dict(marker={"color": "rgb(231,41,138)"}),
            customdata=[(provider, region)],
            hoverinfo="text",
            text=provider
                 + "<br>"
                 + region
                 + "<br>Number of SmartForceps Cases:"
                 + " {:,.0f}".format(val),
        )
        hospitals.append(hospital)

    layout = go.Layout(
        margin=dict(l=10, r=10, t=20, b=10, pad=5),
        plot_bgcolor="#171b26",
        paper_bgcolor="#171b26",
        clickmode="event+select",
        hovermode="closest",
        showlegend=False,
        mapbox=go.layout.Mapbox(
            accesstoken=mapbox_access_token,
            bearing=10,
            center=go.layout.mapbox.Center(
                lat=filtered_data.lat.mean(), lon=filtered_data.lon.mean()
            ),
            pitch=5,
            zoom=5,
            style="mapbox://styles/plotlymapbox/cjvppq1jl1ips1co3j12b9hex",
        ),
    )

    return {"data": hospitals, "layout": layout}


tab_style = {
    'background-color': '#1E2130',
    'text-transform': 'uppercase',
    'font-weight': '600',
    'font-size': '16px',
    'height': 'fit-content',
    'cursor': 'pointer',
}

selected_style = {
    'background-color': '#161a28',
    'text-transform': 'uppercase',
    'font-weight': '800',
    'font-size': '16px',
    'letter-spacing': '1px',
    'color': 'inherit',
    'border': '1',
    'border-bottom': '#91dfd2 solid 4px !important',
    'margin-right': '3px',
    'margin-left': '3px',
    'display': 'flex',
    'flex-direction': 'column',
    'align-items': 'center',
    'justify-content': 'center',
    'cursor': 'pointer',
    'height': '18px',
}

def build_tab_1():
    return dcc.Tab(
        id="Geospatial-tab",
        label="Geospatial Information",
        children=[
            html.Div(
                id="first-tab",
                className="row",
                children=[
                    html.Div(
                        id="first-panel",
                        className="twelve columns",
                        children=[
                            html.Div(
                                id="first-left-column",
                                className="six columns",
                                children=[
                                    html.P(
                                        className="section-title",
                                        children="Choose a country to see its SmartForceps data",
                                    ),
                                    html.Div(
                                        className="control-row-1",
                                        children=[
                                            html.Div(
                                                id="country-select-outer",
                                                children=[
                                                    html.Label("Select a Country"),
                                                    dcc.Dropdown(
                                                        id="country-select",
                                                        options=[{"label": i, "value": i} for i in
                                                                 country_list],
                                                        value=country_list[0],
                                                    ),
                                                ],
                                            ),
                                        ],
                                    ),
                                    html.Div(
                                        id="region-select-outer",
                                        className="control-row-2",
                                        children=[
                                            html.Label("Pick a State/Province"),
                                            html.Div(
                                                id="checklist-container",
                                                children=dcc.Checklist(
                                                    id="region-select-all",
                                                    options=[
                                                        {"label": "Select All Regions",
                                                         "value": "All"}],
                                                    value=[],
                                                ),
                                            ),
                                            html.Div(
                                                id="region-select-dropdown-outer",
                                                children=dcc.Dropdown(
                                                    id="region-select",
                                                    multi=True,
                                                    searchable=True,
                                                ),
                                            ),
                                        ], style={'marginTop': 30}
                                    ),
                                    html.Div(
                                        id="table-container",
                                        className="table-container",
                                        children=[
                                            html.Div(
                                                id="table-upper",
                                                children=[
                                                    html.P("SmartForceps Cases Summary"),
                                                    dcc.Loading(children=html.Div(
                                                        id="case-stats-container"
                                                    )),
                                                ],
                                            ),

                                        ], style={'marginTop': 30}
                                    ),

                                ],
                            ),

                            html.Div(
                                id="geo-map-outer",
                                className="six columns",
                                children=[
                                    html.P(
                                        id="map-title",
                                        children="SmartForceps Cases in {}".format(
                                            country_map[country_list[0]]
                                        ),
                                    ),
                                    html.Div(
                                        id="geo-map-loading-outer",
                                        children=[
                                            dcc.Loading(
                                                id="loading",
                                                children=dcc.Graph(
                                                    id="geo-map",
                                                    figure={
                                                        "data": [],
                                                        "layout": dict(
                                                            plot_bgcolor="#171b26",
                                                            paper_bgcolor="#171b26",
                                                        ),
                                                    },
                                                ),
                                            )
                                        ], style={'height': 200},
                                    ),
                                ],
                            ),

                        ],
                    )
                ],
            ),
        ],
        style=tab_style,
        selected_style=selected_style,
    )


def build_tab_2():
    return dcc.Tab(
        id="Surgical-force-tab",
        label="Surgical Force Data",
        children=[
            html.Div(
                id="second-tab",
                className="row",
                children=[
                    html.Div(
                        id="second-panel",
                        className="twelve columns",
                        children=[
                            html.Div(
                                id="second-left-column",
                                className="six columns",
                                children=[
                                    html.P(
                                        className="section-title",
                                        children="Select a feature from the list and a task segment "
                                                 "from the graph below",
                                    ),

                                    dcc.Dropdown(
                                        id="feature-select",
                                        options=[{"label": i, "value": i}
                                                 for i in force_labels.feature],
                                        value='DurationForce'
                                    ),

                                    html.Div(
                                        id="feature-chart-outer",
                                        className="twelve columns",
                                        children=[
                                            html.Div(
                                                id="distribution-plot-loading-outer",
                                                children=[
                                                    dcc.Loading(
                                                        id="loading-distribution",
                                                        children=dcc.Graph(
                                                            id="distribution-plot",
                                                            hoverData={'points': [{'customdata': '1'}]},
                                                            figure={
                                                                "data": [],
                                                                "layout": {
                                                                    "height": 500,
                                                                },
                                                            },
                                                        ),
                                                    )
                                                ], style={'height': 500, 'marginTop': 30},
                                            ),
                                        ],
                                    ),

                                ],
                            ),

                            html.Div(
                                id="feature-time-series-outer",
                                className="six columns",
                                children=[
                                    html.Div(
                                        id="feature-time-series-container",
                                        children=[
                                            dcc.Loading(
                                                id="loading-right",
                                                children=dcc.Graph(
                                                    id="time-series",
                                                    figure={
                                                        "data": [],
                                                        "layout": {
                                                            "height": 300,
                                                        },
                                                    },
                                                ),
                                            )
                                        ], style={'marginTop': 100}
                                    ),
                                ],
                            ),

                        ], style={'marginTop': 20}
                    )
                ],
            ),
        ],
        style=tab_style,
        selected_style=selected_style,
    )


dash_app.layout = html.Div(
    id="tabs",
    className="tabs",
    children=[
        html.Div(
            id="banner",
            className="banner",
            children=[
                html.H6(children="SmartForceps Data Analytics",
                        style={'color': 'white'}),
                html.A(html.Button('LEARN MORE',
                                   className='twelve columns',
                                   style={'color': 'white'}),
                       href='https://orbsurgical.com/products/smartforceps',
                       style={'marginLeft': 550}),
                html.Img(id="logo", src=dash_app.get_asset_url("orb-surgical-logo.png"),
                         style={'height': '100%'}),
            ],
        ),
        dcc.Tabs(
            id="app-tabs",
            children=[
                build_tab_1(),
                build_tab_2(),
            ], colors={"primary": "#1975FA"}
        )
    ],
)

@dash_app.callback(
    [
        Output("region-select", "value"),
        Output("region-select", "options"),
        Output("map-title", "children"),
    ],
    [Input("region-select-all", "value"), Input("country-select", "value")],
)
def update_region_dropdown(select_all, country_select):
    country_raw_data = data_dict[country_select]
    regions = country_raw_data["Hospital Province"].unique()
    options = [{"label": i, "value": i} for i in regions]

    ctx = dash.callback_context
    if ctx.triggered[0]["prop_id"].split(".")[0] == "region-select-all":
        if select_all == ["All"]:
            value = [i["value"] for i in options]
        else:
            value = dash.no_update
    else:
        value = regions[:1]
    return (
        value,
        options,
        "SmartForceps Case Data in {}".format(country_map[country_select]),
    )


@dash_app.callback(
    Output("checklist-container", "children"),
    [Input("region-select", "value")],
    [State("region-select", "options"), State("region-select-all", "value")],
)
def update_checklist(selected, select_options, checked):
    if len(selected) < len(select_options) and len(checked) == 0:
        raise PreventUpdate()

    elif len(selected) < len(select_options) and len(checked) == 1:
        return dcc.Checklist(
            id="region-select-all",
            options=[{"label": "Select All Regions", "value": "All"}],
            value=[],
        )

    elif len(selected) == len(select_options) and len(checked) == 1:
        raise PreventUpdate()

    return dcc.Checklist(
        id="region-select-all",
        options=[{"label": "Select All Regions", "value": "All"}],
        value=["All"],
    )


@dash_app.callback(
    Output("case-stats-container", "children"),
    [
        Input("geo-map", "selectedData"),
        Input("country-select", "value"),
    ],
)
def update_hospital_datatable(geo_select, country_select):
    country_agg = generate_aggregation(data_dict[country_select])
    geo_data_dict = {
        "Hospital Name": [],
        "City": [],
        "Street Address": [],
        "Number of SmartForceps": [],
        "Number of Surgeons": [],
        "Number of Cases": [],
    }

    ctx = dash.callback_context
    if ctx.triggered:
        prop_id = ctx.triggered[0]["prop_id"].split(".")[0]

        if prop_id == "geo-map" and geo_select is not None:

            for point in geo_select["points"]:
                provider = point["customdata"][0]
                dff = country_agg[country_agg["Hospital Name"] == provider]

                geo_data_dict["Hospital Name"].append(point["customdata"][0])
                geo_data_dict["City"].append(point["customdata"][1])

                address = dff["Hospital Street Address"].tolist()[0]
                geo_data_dict["Street Address"].append(address)

                geo_data_dict["Number of SmartForceps"].append(dff["Number of SmartForceps"]["sum"].tolist()[0])
                geo_data_dict["Number of Surgeons"].append(dff["Number of Surgeons"]["sum"].tolist()[0])
                geo_data_dict["Number of Cases"].append(dff["Number of Cases"]["sum"].tolist()[0])

        geo_data_df = pd.DataFrame(data=geo_data_dict)
        data = geo_data_df.to_dict("rows")

    else:
        data = [{}]

    return dash_table.DataTable(
        id="case-stats-table",
        columns=[{"name": i, "id": i} for i in geo_data_dict.keys()],
        data=data,
        filter_action="native",
        page_size=5,
        style_cell={"background-color": "#242a3b", "color": "#7b7d8d"},
        style_as_list_view=False,
        style_header={"background-color": "#1f2536", "padding": "0px 5px"},
    )


@dash_app.callback(
    Output("geo-map", "figure"),
    [
        Input("region-select", "value"),
        Input("country-select", "value"),
    ],
)
def update_geo_map(region_select, country_select):
    country_agg_data = generate_aggregation(data_dict[country_select])

    return generate_geo_map(country_agg_data, region_select)



@dash_app.callback(
    Output("distribution-plot", "figure"),
    [Input("feature-select", "value"), ],
)
def update_distribution_plot(feature_select):
    dff_feature = df_feature[df_feature['FeatureName'] == feature_select]
    return gen_distribution_plot(dff_feature, feature_select)


@dash_app.callback(
    Output("time-series", "figure"),
    [Input("distribution-plot", "hoverData"), ],
)
def update_timeseries(hoverData):
    dff_processed = df_processed[df_processed['SegmentNumOverall'] == hoverData['points'][0]['customdata']]
    dff_r_processed = dff_processed[dff_processed['ProngName'] == 'RightForce']
    dff_l_processed = dff_processed[dff_processed['ProngName'] == 'LeftForce']
    return gen_timeseries(dff_r_processed, dff_l_processed)


if __name__ == '__main__':
    dash_app.run_server(debug=True)

# if __name__ == "__main__":
#     app.run_server(debug=True)
