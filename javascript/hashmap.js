/*
Start by creating a HashMap class or factory function. 
It’s up to you which you want to use. 
It should have at least two variables for load factor and capacity. 
For a load factor of 0.75 you should have an initial capacity of size 16. Then proceed to create the following methods:
*/

import { LinkedList } from "./linked_list.js"
import { Node } from "./node.js"

export class HashMap {
    constructor() {
        this.loadFactor = 0.75;
        this.capacity = 16;
        this.array = new Array(16).fill(new LinkedList());
    }

    /*
    hash(key) takes a key and produces a hash code with it. 

    However, there is one edge case our hash function still needs to address. 
    For very long keys, our hash code will exceed the maximum integer value allowed by JavaScript. 
    Once that happens, calculations become inaccurate, and the chance of collisions significantly increases. 
    One way to avoid this issue is to apply the modulo % operator on each iteration instead of outside the loop at the end.

    You may remember from the previous lesson that we used modulo % operator at the end of the hash function to fit the 
    final hash into the bucket array. This approach still works for sizing, but placing modulo % operator inside the loop 
    helps avoid integer overflow for long keys while still keeping the result within bucket range.

    */

    hash(key) {
        let hashCode = 0;

        const primeNumber = 31;
        for (let i = 0; i < key.length; i++) {
            hashCode = primeNumber * hashCode + key.charCodeAt(i);

            hashCode %= 16;
        }

        return hashCode;
    }

/*


You may remember from the previous lesson that we used modulo % operator at the end of the hash function to fit the 
final hash into the bucket array. This approach still works for sizing, but placing modulo % operator inside the loop 
helps avoid integer overflow for long keys while still keeping the result within bucket range.

You might find yourself confusing keys with hash codes while accessing key-value pairs later. 
We would like to stress that the key is what your hash function will take as an input. 
In a way, we could say that the key is important for us only inside the hash function, 
as we never access a bucket directly with the key. Instead, we always do so with the hash code.

Limiting key types to strings
In the real world, hash maps can accommodate various data types as keys, including numbers, strings, or objects. 
However, for this project, we will only handle keys of type string.

set(key, value) takes two arguments: the first is a key, and the second is a value that is assigned to this key. 
If a key already exists, then the old value is overwritten, and we can say that we update the key’s value 
(e.g. Carlos is our key but it is called twice: once with value I am the old value., and once with value I am the new value.. 
Following this logic, Carlos should contain only the latter value).
*/

set(key, value) {
    // use key to figure out the bucket to store the data in
    const bucket = this.hash(key);

    // if bucket is empty, set the value
    if (this.array[bucket].head === null ) {
        // create a node
        const node = new Node([key, value]);
        // assign it as head
        this.array[bucket].append(node)
        console.log(this.array[bucket].head)
    // if key exists in bucket, replace with new value
    } else if (this.array[bucket].head !== null && this.array[bucket].head.value[0] === key) {
        this.array[bucket].head.value[1] = value;
        console.log(this.array[bucket])
    // else if bucket is not empty, create a linked list
    } else {
        const node = new Node([key, value]);
        this.array[bucket].append(node)
        console.log(this.array[bucket].head)
    }
    
}

/*
Recall that collisions occur when TWO DIFFERENT keys generate the same hash code and get assigned to the same bucket. 
(e.g. Rama and Sita are both hashed to 3, so 3 becomes a location for Rama AND Sita. 
However, we know that this is not an update because the keys are different). 
Review the dealing with collisions section of the previous lesson to find a way to handle our collisions.

Remember to grow your buckets to double their capacity when your hash map reaches the load factor. 
The methods mentioned later in this assignment can help you handle the growth logic, so you may want 
to implement this feature near the end. However, we mention this with set() because it’s important 
to grow buckets exactly as they are being expanded.
get(key) takes one argument as a key and returns the value that is assigned to this key. If a key is not found, return null.

has(key) takes a key as an argument and returns true or false based on whether or not the key is in the hash map.

remove(key) takes a key as an argument. If the given key is in the hash map, 
it should remove the entry with that key and return true. If the key isn’t in the hash map, it should return false.

length() returns the number of stored keys in the hash map.

clear() removes all entries in the hash map.

keys() returns an array containing all the keys inside the hash map.

values() returns an array containing all the values.

entries() returns an array that contains each key, value pair. Example: [[firstKey, firstValue], [secondKey, secondValue]]

Remember that a hash map does not preserve insertion order when you are retrieving your hash map’s data. 
It is normal and expected for keys and values to appear out of the order you inserted them in.

*/

}