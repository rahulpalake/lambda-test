'use strict';

const expect = require('chai').expect;
const AWS = require('aws-sdk');
const AWS_REGION = process.env.AWS_DEFAULT_REGION || 'us-west-2';
AWS.config.update({region: AWS_REGION});
const lambda = new AWS.Lambda({apiVersion: '2015-03-31'});

function callGreeterLambda(name) {
    const params = {
        FunctionName: 'GreetingLambda'
    };
    if (name) {
        params.Payload = JSON.stringify({name: name});
    }
    return lambda.invoke(params).promise();
}


describe('Greeting Lambda integration tests', () => {

    it('Returns the name if it is provided', done => {
        callGreeterLambda('Clark Kent')
            .then(data => {
                expect(data.StatusCode).to.eql(200);
                const payload = JSON.parse(data.Payload);
                expect(payload.greeting).to.eql('Hello, Clark Kent!');
                done();
            })
            .catch(done);
    });

    it('Defaults to Hello World if no name is provided', done => {
        callGreeterLambda()
            .then(data => {
                expect(data.StatusCode).to.eql(200);
                const payload = JSON.parse(data.Payload);
                expect(payload.greeting).to.eql('Hello, World!');
                done();
            })
            .catch(done);
    });

});