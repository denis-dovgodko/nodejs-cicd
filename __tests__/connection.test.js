
const axios = require('axios');

test('should get index', async () => {
  const response = await axios.get('http://localhost');
  expect(response.status).toBe(200);
  expect(response.data).toHaveProperty('status', 'ok');
});