export { Node };

class Node {
  constructor(value = null, nextNode = null) {
    this.value = value;
    this.nextNode = null;
  }
}