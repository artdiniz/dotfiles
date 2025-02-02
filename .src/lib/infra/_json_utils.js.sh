#!/usr/bin/env node
const arguments = process.argv.slice(2)

const operationName = arguments[0]

const [options, optionsIdx] = (() => {
    const options = {
        isBeautifull: false
    }

    let optionsIdx = 1
    while(`${arguments[optionsIdx]}`.startsWith('-')) {
        switch(arguments[optionsIdx]) {
            case "--beautiful":
            case "-b":
                options.isBeautifull = true
                ;
        }
        optionsIdx++
    }

    return [options, optionsIdx]
})()

let statusCode = 0
switch(operationName) {
    case "read":
        statusCode = readJSONPrimitiveValue(options, ...arguments.slice(optionsIdx))
        process.exit(statusCode)
    ;
    case "read-parsed":
        statusCode = readJSONParsedValue(options, ...arguments.slice(optionsIdx))
        process.exit(statusCode)
    ;
    case "write":
        statusCode = writeJSONValue(options, ...arguments.slice(optionsIdx))
        process.exit(statusCode)
    ;
}


function readJSONPrimitiveValue(options, jsonString = "", propPath = "") {
    const path = propPath.split('.').filter(Boolean)

    let json
    try {
        json = JSON.parse(jsonString)
    } catch (error) {
        console.error('Invalid JSON')
        console.error(error)
        return 126
    }

    let resultJSON = json
    const searchedPath = []
    for(const pathProp of path) {
        searchedPath.push(pathProp)
        if(!(pathProp in resultJSON)) {
            resultJSON = resultJSON[pathProp] = undefined
            continue
            // const pathString = searchedPath.join('.')
            // console.error(`${pathString} doesn't exist on the provided JSON`)
            // return 127
        }
        resultJSON = resultJSON[pathProp]
    }

    let resultJSONString
    try {
        resultJSONString = options.isBeautifull 
            ? JSON.stringify(resultJSON, null, 2)
            : JSON.stringify(resultJSON)
    } catch (error) {
        const pathString = searchedPath.join('.')
        console.error(`Invalid JSON result for prop path ${pathString}`)
        return 128
    }

    console.log(resultJSONString)
}

function readJSONParsedValue(options, jsonString = "", propPath = "") {
    const path = propPath.split('.').filter(Boolean)

    let json
    try {
        json = JSON.parse(jsonString)
    } catch (error) {
        console.error('Invalid JSON')
        console.error(error)
        return 126
    }

    let resultJSON = json
    const searchedPath = []
    for(const pathProp of path) {
        searchedPath.push(pathProp)
        if(!(pathProp in resultJSON)) {
            resultJSON = resultJSON[pathProp] = undefined
            continue
            // const pathString = searchedPath.join('.')
            // console.error(`${pathString} doesn't exist on the provided JSON`)
            // return 127
        }
        resultJSON = resultJSON[pathProp]
    }

    let resultJSONString
    try {
        const isPrimitiveResult = typeof resultJSON !== 'object'
        
        const resultJSONAsObject = isPrimitiveResult
            ? resultJSON
            : JSON.parse(resultJSON)
        
        resultJSONString = isPrimitiveResult
            ? `${resultJSON}`
            : options.isBeautifull
                ? JSON.stringify(resultJSONAsObject, null, 2)
                : JSON.stringify(resultJSONAsObject)
    } catch (error) {
        const pathString = searchedPath.join('.')
        console.error(`Invalid JSON result for prop path ${pathString}`)
        return 128
    }

    console.log(resultJSONString)
}

function writeJSONValue(options, jsonString = "", propPath = "", propValue = undefined) {
    const path = propPath.split('.').filter(Boolean)

    let json
    try {
        json = JSON.parse(jsonString)
    } catch (error) {
        console.error('Invalid JSON')
        console.error(error)
        return 126
    }

    let resultJSON = json
    const searchedPath = []

    for(let i = 0 ; i < (path.length - 1); i++) {
        const pathProp = path[i]
        searchedPath.push(pathProp)
        if(!(pathProp in resultJSON)) {
            resultJSON = resultJSON[pathProp] = {}
            continue
            // const pathString = searchedPath.join('.')
            // console.error(`${pathString} doesn't exist on the provided JSON`)
            // return 126
        }
        resultJSON = resultJSON[pathProp]
    }

    const toWriteProp = path[path.length - 1]
    if(propValue !== undefined) {
        try {
            resultJSON[toWriteProp] = JSON.parse(propValue)
        } catch(error) {
            console.error('Value to be written is not a valid JSON')
            console.error(error)
            return 127
        }
    } else {
        resultJSON[toWriteProp] = undefined
    }

    let resultJSONString
    try {
        resultJSONString = JSON.stringify(json)
    } catch (error) {
        const pathString = searchedPath.join('.')
        console.error(`Invalid JSON result for prop path ${pathString}`)
        return 128
    }

    console.log(resultJSONString)
}
