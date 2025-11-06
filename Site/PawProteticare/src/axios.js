import axios from 'axios';

const endFetch = axios.create({
  baseURL: 'http://localhost:8081',
  withCredentials: true,
});

// ✅ Interceptador que adiciona o token JWT automaticamente
endFetch.interceptors.request.use((config) => {
  const token = localStorage.getItem('access_Token'); // ou onde você armazenou o token

  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }

  return config;
}, (error) => {
  return Promise.reject(error);
});

export default endFetch;
