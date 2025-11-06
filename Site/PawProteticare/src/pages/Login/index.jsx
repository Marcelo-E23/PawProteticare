import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import endFetch from '../../axios';
import style from './login.module.css';
import botao from '../../css/botao.module.css';

function decodeJwtPayload(access_token) {
  const parts = access_token.split('.');
  if (parts.length !== 3) throw new Error('Token JWT inválido');

  const payloadBase64Url = parts[1];
  const payloadBase64 = payloadBase64Url.replace(/-/g, '+').replace(/_/g, '/');
  const payloadJson = atob(payloadBase64);
  return JSON.parse(payloadJson);
}

const Login = () => {
  const [login, setLogin] = useState('');
  const [senha, setSenha] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');

    try {
      console.log(login, senha);
      const response = await endFetch.post('/auth/authenticate', { 
        email: login, 
        password: senha 
      });
      
      console.log('Response completa:', response);
      console.log('Response data:', response.data);
      const { access_token, refreshToken} = response.data;

      localStorage.setItem('access_Token', access_token);
      localStorage.setItem('refreshToken', refreshToken);


      const payload = decodeJwtPayload(access_token);
      console.log("id usuário:", payload.id);

      if (payload.role !== 'ADMIN') {
      setError('Acesso negado: apenas administradores podem entrar.');
      return; 
    }
      navigate('/home');
    } catch (error) {
      console.error(error);
      setError('Usuário ou senha incorretos');
    }
  };

  return (
    <div className={style.login}>
      <form onSubmit={handleSubmit}>
        <div>
          <label htmlFor="usuario">Usuário (Email)</label>
          <input 
            type="text"
            id="usuario"
            value={login}
            onChange={(e) => setLogin(e.target.value)}
            required
            placeholder="Digite seu email"
          />
        </div>

        <div>
          <label htmlFor="senha">Senha</label>
          <input
            type="password"
            id="senha"
            value={senha}
            onChange={(e) => setSenha(e.target.value)}
            required
            placeholder="Digite sua senha"
          />
        </div>

        {error && <p className={style.erro}>{error}</p>}

        <button className={botao.bblue} type="submit">Entrar</button>
      </form>
    </div>
  );
};

export default Login;
