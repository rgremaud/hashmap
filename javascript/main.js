import { HashMap } from "./hashmap.js";

const hashMap = new HashMap();


hashMap.set("Romain", "Test");
hashMap.set("Theo", "Theo");
hashMap.set("Whitney", "Peepee");


console.log(hashMap.length());
hashMap.clear();
console.log(hashMap.length());


