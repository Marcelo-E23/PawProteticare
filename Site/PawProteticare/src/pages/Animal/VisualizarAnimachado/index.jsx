import styles from './visualizar.module.css';
import Header from '../../../components/Header';
import endFetch from '../../../axios';
import { useState, useEffect } from 'react';
import { Link, useParams } from 'react-router-dom';
import Voltar from '../../../components/Voltar';

export default function VisualizarAnimachado() {
    const { id } = useParams();
    const [animachado, setAnimachado] = useState({
        nome: '',
        especie: '',
        idade: '',
        status: '',
        historia: '',
        protese: '',
        imagem: '',  // Este será o campo de imagem base64
    });
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');

    const getAnimachado = async () => {
        try {
            const response = await endFetch.get(`/animachado/${id}`);
            // A resposta do servidor contém a imagem em base64 e outros dados do animachado
            setAnimachado(response.data);
            setLoading(false);
        } catch (error) {
            setLoading(false);
            setError('Erro ao carregar os dados do animachado');
            console.log(error);
        }
    };

    useEffect(() => {
        getAnimachado();
    }, [id]);

    if (loading) {
        return <div>Carregando...</div>;
    }

    return (
        <>
            <Header />
            <div className={styles.vizualizar}>
                <Link to={'/AnimalAchado'}>
                    <Voltar />
                </Link>
                <h1 className={styles.titulo}>Ficha Animachado</h1>

                <div className={styles.card}>
                    <div className={styles.imagem}>
                        {/* Exibição da imagem base64 */}
                        <img src={animachado.imagem} alt={animachado.nome} className={styles.imagemAchado} />
                        <p>{animachado.nome}</p>
                    </div>

                    <div className={styles.informacoes}>
                        {/* Exibição dos dados do animachado */}
                        <div className={styles.dados}>
                            <p className={styles.caracteristica}>ID do Animachado</p>
                            <div className={styles.animachado}>
                                <p>{animachado.id}</p>
                            </div>
                        </div>

                        <div className={styles.dados}>
                            <p className={styles.caracteristica}>Espécie</p>
                            <div className={styles.animachado}>
                                <p>{animachado.especie}</p>
                            </div>
                        </div>

                        <div className={styles.dados}>
                            <p className={styles.caracteristica}>Idade</p>
                            <div className={styles.animachado}>
                                <p>{animachado.idade}</p>
                            </div>
                        </div>

                        <div className={styles.dados}>
                            <p className={styles.caracteristica}>Status</p>
                            <div className={styles.animachado}>
                                <p>{animachado.status}</p>
                            </div>
                        </div>

                        <div className={styles.dados}>
                            <p className={styles.caracteristica}>Protése</p>
                            <div className={styles.animachado}>
                                <p>{animachado.protese}</p>
                            </div>
                        </div>

                        <div className={styles.dados}>
                            <p className={styles.caracteristica}>História</p>
                            <div className={styles.animachado}>
                                <p>{animachado.historia}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
}
