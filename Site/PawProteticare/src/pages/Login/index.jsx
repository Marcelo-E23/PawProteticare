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
      
      const response = await endFetch.post('/auth/authenticate', {
        email: login,
        password: senha,
      });

      
      const { access_token, role } = response.data;

      
      if (role !== 'ADMIN') {
        setError('Acesso restrito a administradores');
        return;
      }

      
      localStorage.setItem('access_token', access_token);
      localStorage.setItem('user_role', role);

      
      navigate('/home');
    } catch (error) {
      
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

        {}
        {error && <p className={style.erro}>{error}</p>}

        <button className={botao.bblue} type="submit">Entrar</button>
      </form>
    </div>
  );
};

export default Login;
