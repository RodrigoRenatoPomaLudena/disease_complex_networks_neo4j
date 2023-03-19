// CREATE DISEASE NODE
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/RodrigoRenatoPomaLudena/disease_complex_networks_neo4j/master/dataset_cleaned/disease_node.csv" AS row
MERGE (disease:Disease {disease:row.disease})
SET disease.description=row.description;


// CREATE PRECAUTION NODE
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/RodrigoRenatoPomaLudena/disease_complex_networks_neo4j/master/dataset_cleaned/precaution_node.csv" AS row
MERGE (precaution:Precaution {precaution:row.precaution})
SET precaution.weight=row.weight;


// CREATE SYMPTOM NODE
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/RodrigoRenatoPomaLudena/disease_complex_networks_neo4j/master/dataset_cleaned/symptom_node.csv" AS row
MERGE (symptom:Symptom {symptom:row.symptom})
SET symptom.weight=row.weight;


// CREATE USER  NODE
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/RodrigoRenatoPomaLudena/disease_complex_networks_neo4j/master/dataset_cleaned/user_node.csv" AS row
MERGE (user:User {user:row.user})
SET user.email=row.email, user.postalZip=row.postalZip, user.region=row.region, user.country=row.country;


// CREATE USER AND DISEASE RELATIONSHIP
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/RodrigoRenatoPomaLudena/disease_complex_networks_neo4j/master/dataset_cleaned/disease_and_user_node.csv" AS row
MATCH (user:User) WHERE user.user = row.user
MATCH (disease:Disease) WHERE disease.disease = row.disease
MERGE (user)-[:IS_SICK_WITH]->(disease);


// CREATE USER AND SYMPTOM RELATIONSHIP
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/RodrigoRenatoPomaLudena/disease_complex_networks_neo4j/master/dataset_cleaned/user_and_symptom_node.csv" AS row
MATCH (user:User) WHERE user.user = row.user
MATCH (symptom:Symptom) WHERE symptom.symptom = row.symptom
MERGE (user)-[:PRESENTS]->(symptom);

//CREATE DISEASE AND PRECAUTION RELATIONSHIP
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/RodrigoRenatoPomaLudena/disease_complex_networks_neo4j/master/dataset_cleaned/precaution_and_symptom_node.csv" AS row
MATCH (disease:Disease) WHERE disease.disease = row.disease
MATCH (precaution:Precaution) WHERE precaution.precaution = row.precaution
MERGE (disease)-[:IS_TREATED_WITH]->(precaution);
