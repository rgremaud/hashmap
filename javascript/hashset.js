import { LinkedList } from "./linked_list.js";
import { Node } from "./node.js";

export class HashSet {
    constructor(loadFactor = 0.75, capacity = 16) {
        this.loadFactor = loadFactor;
        this.capacity = capacity;
        this.array = Array.from(Array(capacity), () => new LinkedList());
    }
    // good
    hash(key) {
        let hashCode = 0;

        const primeNumber = 31;
        for (let i = 0; i < key.length; i++) {
            hashCode = primeNumber * hashCode + key.charCodeAt(i);

            hashCode %= 16;
        }

        return hashCode;
    }
    
    set(key) {
        const bucket = this.array[this.hash(key)];

        if (bucket.contains(key) !== false) {
            console.log("That key already exists")
        } else {
            const node = new Node(key);
            bucket.append(node);
        }

        const totalEntries = this.length()
        
        if (totalEntries >= this.loadFactor * this.capacity) { 
            const allEntries = this.keys()
            this.clear();
            this.capacity *= 2;
            this.array = Array.from(Array(this.capacity), () => new LinkedList());
            allEntries.forEach((key) => {
                this.set(key);
            })
        }
    }
    
    has(key) {
        const bucket = this.array[this.hash(key)];
        
        if (bucket.contains(key) !== false) {
            return true
        } else {
            return false;
        }
    }
    // good - double check ** stopping point
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
}

