import { HashMap } from "./hashmap.js";

const hashMap = new HashMap();

hashMap.set("Romain", "Test");
hashMap.set("Romain", "Theo");
hashMap.set("Whitney", "Peepee");

console.log(hashMap.remove("Whitney"));


