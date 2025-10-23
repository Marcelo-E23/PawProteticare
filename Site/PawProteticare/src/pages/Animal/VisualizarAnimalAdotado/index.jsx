import styles from './visualizar.module.css';
import Header from '../../../components/Header';
import endFetch from '../../../axios';
import { useState, useEffect } from 'react';
import { Link, useParams } from 'react-router-dom';
import Voltar from '../../../components/Voltar';

export default function VisualizarAnimadotado() {
  const { id } = useParams();

  const [animadotado, setAnimadotado] = useState({
    id: '',
    animachado: {
      nome: '',
      especie: '',
      idade: '',
      status: '',
      historia: '',
      protese: '',
      imagem: ''
    },
    proprietario: {
      nome: '',
      cpf: '',
      email: '',
      cep: '',
      logradouro: '',
      complemento: '',
      telefone: ''
    }
  });

  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  const getAnimadotado = async () => {
    const token = localStorage.getItem('access_token');
    try {
      const response = await endFetch.get(`/animadotado/${id}`,{
                    headers: {
                        Authorization: `Bearer ${token}`,
                             },
                    });
      let data = response.data;

      // Puxar animachado se necessário
      if (data.animachado_id && !data.animachado) {
        const animalRes = await endFetch.get(`/animachado/${data.animachado_id}`,{
                    headers: {
                        Authorization: `Bearer ${token}`,
                             },
                    });
        data.animachado = animalRes.data;
      }

      // Puxar proprietario se necessário
      if (data.proprietario_id && !data.proprietario) {
        const propRes = await endFetch.get(`/usuario/${data.proprietario_id}`,{
                    headers: {
                        Authorization: `Bearer ${token}`,
                             },
                    });
        data.proprietario = propRes.data;
      }

      setAnimadotado(data);
    } catch (err) {
      console.log(err);
      setError('Erro ao carregar os dados do animadotado');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    getAnimadotado();
  }, [id]);

  if (loading) return <div>Carregando...</div>;
  if (error) return <div>{error}</div>;

  const { animachado, proprietario } = animadotado;

  // Gerar link Google Maps a partir do CEP
  const cepFormatado = proprietario.cep?.replace(/\D/g, '');
  const googleMapsUrl = cepFormatado
    ? `https://www.google.com/maps/search/?api=1&query=${cepFormatado}`
    : '#';

  return (
    <>
      <Header />
      <div className={styles.visualizar}>
        <Link to={'/AnimalAdotado'}><p className={styles.voltar}>Voltar</p></Link>
        <h1 className={styles.titulo}>Ficha Animadotado</h1>

        <div className={styles.card}>
          {/* Imagem do animal */}
          <div className={styles.imagem}>
            {animachado.imagem && <img src={animachado.imagem} alt={animachado.nome} />}
            <p>{animachado.nome}</p>
          </div>

          {/* Informações do animal */}
          <div className={styles.informacoes}>
            <div className={styles.dados}>
              <p className={styles.caracteristica}>ID do Animadotado</p>
              <div className={styles.animadotado}><p>{animadotado.id}</p></div>
            </div>

            <div className={styles.dados}>
              <p className={styles.caracteristica}>Espécie</p>
              <div className={styles.animadotado}><p>{animachado.especie || '-'}</p></div>
            </div>

            <div className={styles.dados}>
              <p className={styles.caracteristica}>Idade</p>
              <div className={styles.animadotado}><p>{animachado.idade || '-'} anos</p></div>
            </div>

            <div className={styles.dados}>
              <p className={styles.caracteristica}>Status</p>
              <div className={styles.animadotado}><p>{animachado.status || '-'}</p></div>
            </div>

            <div className={styles.dados}>
              <p className={styles.caracteristica}>Necessidade de Protése</p>
              <div className={styles.animadotado}><p>{animachado.protese || '-'}</p></div>
            </div>

            <div className={styles.dados}>
              <p className={styles.caracteristica}>História</p>
              <div className={styles.animadotado}><p>{animachado.historia || '-'}</p></div>
            </div>

            {/* Informações do proprietário */}
            <h2 className={styles.titulo}>Proprietário</h2>

            <div className={styles.dados}>
              <p className={styles.caracteristica}>Nome</p>
              <div className={styles.animadotado}><p>{proprietario.nome || '-'}</p></div>
            </div>

            <div className={styles.dados}>
              <p className={styles.caracteristica}>CPF</p>
              <div className={styles.animadotado}><p>{proprietario.cpf || '-'}</p></div>
            </div>

            <div className={styles.dados}>
              <p className={styles.caracteristica}>Email</p>
              <div className={styles.animadotado}><p>{proprietario.email || '-'}</p></div>
            </div>

            <div className={styles.dados}>
              <p className={styles.caracteristica}>Telefone</p>
              <div className={styles.animadotado}><p>{proprietario.telefone || '-'}</p></div>
            </div>

            <div className={styles.dados}>
              <p className={styles.caracteristica}>Logradouro</p>
              <div className={styles.animadotado}><p>{proprietario.logradouro || '-'}</p></div>
            </div>

            <div className={styles.dados}>
              <p className={styles.caracteristica}>Complemento</p>
              <div className={styles.animadotado}><p>{proprietario.complemento || '-'}</p></div>
            </div>

            <div className={styles.dados}>
              <p className={styles.caracteristica}>CEP</p>
              <div className={styles.animadotado}>
                <p>{proprietario.cep || '-'}</p>
                {cepFormatado && (
                  <a href={googleMapsUrl} target="_blank" rel="noopener noreferrer">Ver no mapa</a>
                )}
              </div>
            </div>

          </div>
        </div>
      </div>
    </>
  );
}
