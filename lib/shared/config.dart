const  environment = 'dev';

const String url = environment == 'local' ? "http://ctrlpay.test/api" :   environment == 'dev' ? "https://ctrlpay-api-dev.herokuapp.com/api" : "";

