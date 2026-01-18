import { LinkedList } from "./linked_list.js";
import { Node } from "./node.js";

export class HashMap {
    constructor(loadFactor = 0.75, capacity = 16) {
        this.loadFactor = loadFactor;
        this.capacity = capacity;
        this.array = Array.from(Array(16), () => new LinkedList());
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

    length() {
        let length = 0;
        this.array.forEach((bucket) =>
            length += bucket.size()
        )
        return length;
    }

    clear() {
        this.array = Array.from(Array(16), () => new LinkedList());
    }

    keys() { 
        const keyArray = []
        this.array.forEach((bucket) => {
            const keys = bucket.arrayKeys();
            keyArray.push(keys);
        })
        
        const flatKey = keyArray.flat();

        return flatKey;
    }

    values() { 
        const valueArray = [];
        this.array.forEach((bucket) => {
            const keys = bucket.arrayValues();
            valueArray.push(keys);
        })
        
        const flatKey = valueArray.flat();

        return flatKey;
    }

   entries() {
    const entriesArray = [];
    this.array.forEach((bucket) => {
            const keys = bucket.arrayEntries();
            entriesArray.push(keys);
        })
        
        const flatKey = entriesArray.flat();

        return flatKey;
   }
}
