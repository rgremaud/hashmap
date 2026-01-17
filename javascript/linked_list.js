import { Node } from "./node.js";

export { LinkedList };

class LinkedList {
  constructor() {
    this.head = null;
    this.tail = null;
  }

  append(node) {
    // const node = new Node(value);

    if (this.head === null) {
      this.head = node;
      this.tail = node;
    } else {
      this.tail.nextNode = node;
      this.tail = node;
    }
  }

  prepend(value) {
    const node = new Node(value);

    if (this.head === null) {
      this.head = node;
      this.tail = node;
    } else {
      node.nextNode = this.head;
      this.head = node;
    }
  }

  size() {
    if (this.head === null) return 0;

    let size = 1;
    let node = this.head;

    while (node.nextNode !== null) {
      node = node.nextNode;
      size += 1;
    }

    return size;
  }

  headCheck() {
    if (this.head === null) {
      return undefined;
    } else {
      return this.head.value;
    }
  }

  tailCheck() {
    if (this.tail === null) {
      return undefined;
    } else {
      return this.tail.value;
    }
  }

  at(index) {
    let currentNode = this.head;

    if (index > this.size()) {
      return undefined;
    } else {
      for (let i = 0; i <= index; i++) {
        if (i === index) {
          return currentNode.value;
        } else {
          currentNode = currentNode.nextNode;
        }
      }
    }
  }

  nodeAt(index) {
    let currentNode = this.head;

    if (index > this.size()) {
      return undefined;
    } else {
      for (let i = 0; i <= index; i++) {
        if (i === index) {
          return currentNode;
        } else {
          currentNode = currentNode.nextNode;
        }
      }
    }
  }

  pop() {
    if (this.head === null) {
      return undefined;
    } else {
      this.head = this.head.nextNode;
    }
  }

  contains(key) {
    let node = this.head;
    let keyFound = false;

    if (node === null) {
      return false;
    }

    while (node !== null) {
      if (node.key === key) {
        return node;
      }
      node = node.nextNode;
    }

    return keyFound;
  }

  findIndex(key) {
    let counter = 0;
    let node = this.head;
    while (node !== null) {
      if (node.key === key) {
        return counter;
      }
      counter += 1;
      node = node.nextNode;
    }
    return -1;
  }

  toString() {
    let string = "";
    let node = this.head;
    while (node !== null) {
      string = string + ` ( ${node.value} ) ->`;
      node = node.nextNode;
    }
    string += " null";
    return string;
  }

  insertAt(index, ...values) {
    // create a node for each of the added values
    const newNodes = [];
    values.forEach((value) => {
      const node = new Node(value);
      newNodes.push(node);
    });
    // define nextNode for all newNodes except last one
    newNodes.forEach((node) => {
      if (newNodes.indexOf(node) <= newNodes.length - 2) {
        node.nextNode = newNodes[newNodes.indexOf(node) + 1];
      }
    });

    // define the insertion point and insert new nodes
    if (index < 0 || index > this.size()) {
      return RangeError;
    } else if (index === 0) {
      const shiftNode = this.head;
      newNodes[newNodes.length - 1].nextNode = shiftNode;
      this.head = newNodes[0];
    } else if (index === this.size) {
      const currentTail = this.tail;
      currentTail.nextNode = newNodes[0];

      this.tail = newNodes[newNodes.length - 1];
    } else {
      const insertionNode = this.nodeAt(index - 1);
      const shiftNode = this.nodeAt(index);

      insertionNode.nextNode = newNodes[0];
      newNodes[newNodes.length - 1].nextNode = shiftNode;
    }
  }

  removeAt(index) {
    if (index < 0 || index > this.size()) {
      return RangeError;
    } else if (index === 0) {
      const newHead = this.head.nextNode;
      this.head = newHead;
    } else if (index >= 0) {
      const previousNode = this.nodeAt(index - 1);
      const nodeToRemove = this.nodeAt(index);

      if (nodeToRemove === this.tail) {
        this.tail = previousNode;
      }

      previousNode.nextNode = nodeToRemove.nextNode;

      // ** Removed for hashmap but double check this is accurate **
      // if (previousNode === this.tail) {
      //   this.tail = newNodes[newNodes.length - 1];
      // }
    }
  }

}
