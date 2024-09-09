
const axios = require('axios');

test('should get index', async () => {
  const response = await axios.get('localhost');
  expect(response.status).toBe(200);
  expect(response.data).toHaveProperty('status', 'ok');
});