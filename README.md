[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="images/graph.png" alt="Logo" width="300" height="300">
  </a>

  <h3 align="center">Social Network Analysis of International E-road Network Using Neo4j</h3>

  <p align="center">
    FINAL PROJECT of DS535 Social Network Analysis
    <br />
    in Master degree program in Data Science, Srinakarinwirot University 
    <br />
    Semester 2, 2021
    <br />
    <a href="https://github.com/friendorus/SNA_euroroad/blob/6a27f7fa71ec94a157f43533d2b2e4343f6ce354/Cypher/EUROROAD_project.cql"><strong>Explore my Neo4j code »</strong></a>
    <br />
    <br />
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <!-- <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li> -->
    <li><a href="#about-the-project">About The Project</a></li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#import">Import</a></li>
      </ul>
    </li>
    <!-- <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li> -->
    <li><a href="#medium">Medium</a></li>
    <li><a href="#report">Report</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project
This is the final project in part of DS535 Social Network Analysis, in Master degree program in Data Science, Srinakarinwirot University, 2nd Semester, 2021. This project is about social analysis of international euro road network dataset focusing on using Neo4j Desktop program with Graph Data Science Library to look for Centrality and Community detection. The language using in Neo4j is Cycher Query Language (CQL).



<!-- GETTING STARTED -->
## Getting Started



### Prerequisites

At the begining, you should download data set at [my github](https://github.com/friendorus/SNA_euroroad) which consists of 2 csv files those are [nodes.csv](https://github.com/friendorus/SNA_euroroad/blob/f1baca4a5ade8be92f953ddd9ace954339957c44/Data/nodes.csv) and [edges.csv](https://github.com/friendorus/SNA_euroroad/blob/f1baca4a5ade8be92f953ddd9ace954339957c44/Data/edges.csv)

### Installation

1. Neo4j Desktop can download [here](https://neo4j.com/download/)
1. After Loading csv. files and create your project and database in Neo4j, you need to copy these files to import folder. You can find the import folder by hovering over the three dots to the right started DBMS and selecting __Open folder__, and then __Import__
1. After add csv. file to import folder, you should install plugin for using algotirth. Plugins that you should install are __APOC__ and __Graph Data Science Library__

### Import
- Firstly, Import Nodes to database from [nodes.csv](https://github.com/friendorus/SNA_euroroad/blob/f1baca4a5ade8be92f953ddd9ace954339957c44/Data/nodes.csv) by using this query. I labeled node as City and named the properties of node as __CityID__, __CityName__ and __Position__
```
// LOAD Node and Peoperites to Database
LOAD CSV WITH HEADERS FROM 'file:///nodes.csv' AS row
WITH toInteger(row.index) AS CityID, row.meta AS CityName,row._pos AS Position
MERGE (c:City {CityID:CityID})
SET c.CityName = CityName, c.Position = Position
RETURN count(c);
```
- Then, I imported Edges to the database from [edges.csv](https://github.com/friendorus/SNA_euroroad/blob/f1baca4a5ade8be92f953ddd9ace954339957c44/Data/edges.csv) by using this query. I have to __MATCH__ the nodes that I already added and then put the node to query. I labeled relationship/edges as __CONNECTED__.
```
// Match Node from database and LOAD Relationship to Database
LOAD CSV WITH HEADERS FROM 'file:///edges.csv' AS row
WITH toInteger(row.source) AS City1, toInteger(row.target) AS City2
MATCH (c1:City {CityID: City1})
MATCH (c2:City {CityID: City2})
MERGE (c1)-[rel:CONNECTED]->(c2)
RETURN c1,c2
```
- Now you can visualized type of your nodes and edges by using this query.
```
// Visulaization type of Node and Realationship
CALL db.schema.visualization
```
- I will not show other my query and result on this page. You can find code [here](https://github.com/friendorus/SNA_euroroad/blob/6a27f7fa71ec94a157f43533d2b2e4343f6ce354/Cypher/EUROROAD_project.cql)

<!-- Medium -->
## Medium

I wrote how to import csv file to Neo4j, Neo4j code and all of result in [My Medium.](https://peachapong-poolpol.medium.com/social-network-analysis-of-international-e-road-network-fcf685d3e2dd)

You can also see the code and results of my project from this [Slides](https://github.com/friendorus/SNA_euroroad/blob/6a27f7fa71ec94a157f43533d2b2e4343f6ce354/docs/Result%20of%20SNA%20of%20Euroroad%20Using%20Neo4j.pptx)


<!-- REPORT -->
## Report
I wrote the article report in Thai. You can find it [here](https://github.com/friendorus/SNA_euroroad/blob/6a27f7fa71ec94a157f43533d2b2e4343f6ce354/docs/Report%20of%20SNA%20of%20International%20Euroroad%20network.pdf)

<!-- CONTACT -->
## Contact

Peachapong Poolpol - peachapong.poolpol@g.swu.ac.th

Project Link: [https://github.com/friendorus](https://github.com/friendorus)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* All of Professors in Department of Computer science, Faculty of Science, Srinakarinwirot Univerity
* Assistant Professor, Dr. Supphachai Thaicharoen - supphachai@g.swu.ac.th
* Dr. Jutarat Kriripet from NECTEC - jutarat.khiripet@nectec.or.th



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=for-the-badge
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=for-the-badge
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=for-the-badge
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=for-the-badge
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/othneildrew/Best-README-Template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/peachapong-poolpol-87b440128/
[product-screenshot]: images/screenshot.png
