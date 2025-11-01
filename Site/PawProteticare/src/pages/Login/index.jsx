import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import endFetch from '../../axios';
import style from './login.module.css';
import botao from '../../css/botao.module.css';

const Login = () => {
  const [login, setLogin] = useState('');
  const [senha, setSenha] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');

    try {
      // ✅ Envia os nomes corretos esperados pelo backend
      const response = await endFetch.post('/auth/authenticate', {
        email: login,
        password: senha,
      });

      console.log('Resposta do servidor:', response.data); // debug opcional

      // ✅ Extrai corretamente o token antes de usar
      const { access_token } = response.data;

      // ✅ Decodifica o payload do JWT para pegar dados do usuário
      const payload = decodeJwtPayload(access_token);

      // ✅ Salva no localStorage
      localStorage.setItem('access_token', access_token);
      localStorage.setItem('user_role', payload.role);
      localStorage.setItem('id_user', payload.id);

      // ✅ Redireciona
      navigate('/home');
    } catch (err) {
      console.error('Erro no login:', err);

      if (err.response && err.response.status === 400) {
        setError('Email ou senha incorretos');
      } else if (err.response && err.response.status === 401) {
        setError('Conta inativa ou não autorizada');
      } else {
        setError('Erro ao tentar fazer login. Tente novamente mais tarde.');
      }
    }
  };

  // ✅ Função para decodificar o payload do JWT
  function decodeJwtPayload(token) {
    const parts = token.split('.');
    if (parts.length !== 3) throw new Error('Token JWT inválido');

    const payloadBase64Url = parts[1];
    const payloadBase64 = payloadBase64Url.replace(/-/g, '+').replace(/_/g, '/');
    const payloadJson = atob(payloadBase64);
    return JSON.parse(payloadJson);
  }

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

        {/* Exibe mensagem de erro, se houver */}
        {error && <p className={style.erro}>{error}</p>}

        <button className={botao.bblue} type="submit">
          Entrar
        </button>
      </form>
    </div>
  );
};

export default Login;
