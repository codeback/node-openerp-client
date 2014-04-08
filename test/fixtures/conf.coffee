
conf =
    dbname: "cb-test-new3"
    hostname: "codeback.es"
    port: 8001
    username: "testuser"
    password: "test123pass"

dummyData =
    testId: 6
    itemIds: [1,3,5,7]
    price: 100
    name: "product"

module.exports = 
    conf: conf
    dummyData: dummyData