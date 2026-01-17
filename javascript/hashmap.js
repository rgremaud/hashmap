import { LinkedList } from "./linked_list.js";
import { Node } from "./node.js";

export class HashMap {
    constructor(loadFactor = 0.75, capacity = 16) {
        this.loadFactor = loadFactor;
        this.capacity = capacity;
        this.array = new Array(capacity).fill(new LinkedList());
    }

    hash(key) {
        let hashCode = 0;

        const primeNumber = 31;
        for (let i = 0; i < key.length; i++) {
            hashCode = primeNumber * hashCode + key.charCodeAt(i);

            hashCode %= 16;
        }

        return hashCode;
    }

    // need to re-work to test the loadFactor / capacity and then re-work the hash by expanding
    // implement the growth at end after other functions built
    // maximum capacity is calculated by loadFactor * capacity
    // example, .75 * 16 = 12
    // so on 13th entry you will increase the capacity by a fatcor 2
    // this will require re-hashing everything
    set(key, value) {
        const bucket = this.array[this.hash(key)];

        if (bucket.contains(key) !== false) {
            const node = bucket.contains(key);
            node.value = value;
        } else {
            const node = new Node(key, value);
            bucket.append(node);
        }
    }

    get(key) {
        const bucket = this.array[this.hash(key)];

        if (bucket.contains(key) !== false) {
            const node = bucket.contains(key);
            return node.value;
        } else {
            return null;
        }
    }

    has(key) {
        const bucket = this.array[this.hash(key)];
        console.log(bucket);
        if (bucket.contains(key) !== false) {
            return true
        } else {
            return false;
        }
    }


    /*  
        remove(key) takes a key as an argument. If the given key is in the hash map, 
        it should remove the entry with that key and return true. If the key isn’t in the hash map, it should return false.
        works for head of list and seems to work for tail
    */
    remove(key) {
        const bucket = this.array[this.hash(key)];
        // if bucket.findIndex(key) !== -1
        if (bucket.findIndex(key) !== -1) {
            const index = bucket.findIndex(key);
            console.log(bucket);
            bucket.removeAt(index);
            console.log(bucket);
            return true
        } else {
            console.log(bucket.findIndex(key))
            return false;
        }
    }

    /*
        length() returns the number of stored keys in the hash map.
        
        clear() removes all entries in the hash map.
        
        keys() returns an array containing all the keys inside the hash map.
        
        values() returns an array containing all the values.
        
        entries() returns an array that contains each key, value pair. Example: [[firstKey, firstValue], [secondKey, secondValue]]
        
        Remember that a hash map does not preserve insertion order when you are retrieving your hash map’s data. 
        It is normal and expected for keys and values to appear out of the order you inserted them in.
        
        */
}
