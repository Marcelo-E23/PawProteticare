import axios from 'axios';

const endFetch = axios.create({
  baseURL: 'http://localhost:8081',
  withCredentials: true,
  headers: {
    'Content-Type': 'multipart/form-data',
  },
});

// ✅ Interceptador que adiciona o token JWT automaticamente
endFetch.interceptors.request.use((config) => {
  const token = localStorage.getItem('accessToken'); // ou onde você armazenou o token

  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }

  return config;
}, (error) => {
  return Promise.reject(error);
});

export default endFetch;
