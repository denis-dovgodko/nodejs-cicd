
const axios = require('axios');

test('should get index', async () => {
  const response = await axios.get('http://127.0.0.1:80/');
  expect(response.status).toBe(200);
  expect(response.data);
});