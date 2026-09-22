module.exports = {
  default: {
    require: ['steps/*.js'],
    format: ['summary', 'junit:test-results/results.xml'],
    paths: ['features/*.feature'],
  },
};
