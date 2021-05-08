CREATE CONSTRAINT ON (c:City) ASSERT c.CityName IS UNIQUE;

// LOAD Node and Peoperites to Database
LOAD CSV WITH HEADERS FROM 'file:///nodes.csv' AS row
WITH toInteger(row.index) AS CityID, row.meta AS CityName,row._pos AS Position
MERGE (c:City {CityID:CityID})
SET c.CityName = CityName, c.Position = Position
RETURN count(c);

// Match Node from database and LOAD Relationship to Database
LOAD CSV WITH HEADERS FROM 'file:///edges.csv' AS row
WITH toInteger(row.source) AS City1, toInteger(row.target) AS City2
MATCH (c1:City {CityID: City1})
MATCH (c2:City {CityID: City2})
MERGE (c1)-[rel:CONNECTED]->(c2)
RETURN c1,c2;

// Visulaization type of Node and Realationship
CALL db.schema.visualization;

// Visualize all of node and relationship in Database
MATCH (p)
RETURN p;

//Try to find the node named Modena and its adjacent nodes
MATCH (p{CityName:'Modena'})--(q)
RETURN p,q;

// Try to find degree of Node name Modena in the simple way
MATCH (p{CityName:'Modena'})-[r]-()
WITH p, count(r) as DegreeScore
SET p.degree = DegreeScore
RETURN p.degree;

//Update degree as a new proterties of Node
MATCH (p)-[r]-()
WITH p, count(r) as DegreeScore
SET p.degree = DegreeScore
RETURN p.degree;


// Try to find node where have degree more than 6
MATCH (p)-[r]-()
WITH p, count(r) as DegreeScore
WHERE DegreeScore>6
RETURN p, DegreeScore;

//Find node and degree where have deree more than 7
MATCH (p)
WHERE p.degree>7
RETURN p.CityName, p.degree As degree
ORDER BY degree DESC;

// Try to show nodes where are the top 10 of highest degree
MATCH (p)-[r]-()
WITH p, count(r) as DegreeScore
SET p.degree = DegreeScore
RETURN p,p.degree ORDER BY p.degree DESC LIMIT 10;

// Try to show the relationship of Node named Moscow
MATCH (p{CityName:'Moscow'})--(q)
RETURN p,q;

// Try to find the shortest path from Berlin to Vienna
MATCH s=shortestPath( (p{CityName:'Berlin'})-[*]-(q{CityName:'Vienna'})) 
RETURN s;

//Try to find 2 hop cities away from Tallinn
MATCH (p{CityName:"Tallinn"})-[*1..2]-(q)
RETURN p, q;

//Grpah Data Science Library
//Create graph to run on GDS by assign node, relationship and type of edge
CALL gds.graph.create('euroroad2','City',
{CONNECTED:{orientation:'UNDIRECTED'}});


//CENTRALITY
//Find Degree centrality using GDS by showing top ten of degree centrality
CALL gds.alpha.degree.stream('euroroad2') 
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).CityName AS node, score AS degree_centrality_score 
ORDER BY degree_centrality_score DESC
LIMIT 10;


//Find Betweenness Centrality using GDS by showing top ten of Betweenness Centrality
CALL gds.betweenness.stream('euroroad2')
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).CityName AS name, score
ORDER BY score DESC LIMIT 10;


//Find Closeness Centrality
CALL gds.alpha.closeness.stream('euroroad2') YIELD nodeId, centrality AS score
WITH gds.util.asNode(nodeId).CityName AS node, score
WITH collect(node) AS allNodes, score
RETURN allNodes, score
ORDER BY score DESC
LIMIT 10;

//Find Eigenvector
CALL gds.alpha.eigenvector.stream('euroroad2') YIELD nodeId, score
WITH gds.util.asNode(nodeId).CityName AS node, score
RETURN node, score
ORDER BY score DESC
LIMIT 10;

//COMMUNITY DETECTION
//Louvain method
CALL gds.louvain.stream('euroroad2')
YIELD nodeId, communityId AS community
WITH gds.util.asNode(nodeId).CityName AS node, community
WITH community, collect(node) AS nodes
RETURN community, nodes, size(nodes) AS size
ORDER BY size DESC;

//Lovain with intermediate community
CALL gds.louvain.stream('euroroad2')
YIELD nodeId, communityId AS community, intermediateCommunityIds AS communities
WITH gds.util.asNode(nodeId).CityName AS node, community, communities
WITH community, communities, collect(node) AS nodes
RETURN community, communities, size(nodes) AS size, nodes
ORDER BY size DESC;

//Weakly connected component
CALL gds.wcc.stream('euroroad2') YIELD nodeId, componentId AS community
WITH gds.util.asNode(nodeId).CityName AS node, community
WITH collect(node) AS allNodes, community
RETURN community,size(allNodes) AS size, allNodes AS nodes
ORDER BY size DESC;

//Label Propragation Algorithm
CALL gds.labelPropagation.stream('euroroad2') YIELD nodeId, communityId AS community
WITH gds.util.asNode(nodeId).CityName AS node, community
WITH collect(node) AS allNodes, community
RETURN community, allNodes AS nodes, size(allNodes) AS size
ORDER BY size DESC;

// Triangle count
CALL gds.triangleCount.stream('euroroad2')
YIELD nodeId, triangleCount AS triangles
WITH gds.util.asNode(nodeId).CityName AS node, triangles
WITH collect(node) AS allNodes, triangles,count(node) AS Node
RETURN allNodes, triangles, Node
ORDER BY triangles DESC;

//Triangle count with graph visualization
CALL gds.alpha.triangles('euroroad2')
YIELD nodeA, nodeB, nodeC
RETURN gds.util.asNode(nodeA) AS nodeA, gds.util.asNode(nodeB) AS nodeB, gds.util.asNode(nodeC) AS nodeC;


//Local Clustering coefficient
CALL gds.localClusteringCoefficient.stream('euroroad2')
YIELD nodeId, localClusteringCoefficient AS coefficient
WITH gds.util.asNode(nodeId).CityName AS node, coefficient
RETURN node, coefficient
ORDER BY coefficient DESC;

CALL gds.localClusteringCoefficient.stream('euroroad2')
YIELD nodeId, localClusteringCoefficient AS coefficient
WITH gds.util.asNode(nodeId).CityName AS node, coefficient
WITH collect(node) AS nodes, coefficient
RETURN nodes, coefficient
ORDER BY coefficient DESC;

