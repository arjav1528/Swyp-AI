class APIResonse {
  constructor(statusCode, data,message = "Success") {
    this.statusCode = statusCode;
    this.data = data;
    this.message = message;
  }
}


class APIError extends Error {
    constructor(
        statusCode,
        message = "An error occurred",
        errors = [],
        stack = ""
    ){
        super(message);
        this.statusCode = statusCode;
        this.data = null;
        this.message = message;
        this.succes = false;
        this.error = errors;
        if(stack){
            this.stack = stack;
        } else {
            Error.captureStackTrace(this, this.constructor);
        }
    }
}

module.exports = {APIResonse, APIError};