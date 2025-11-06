import styles from './visualizar.module.css';
import Header from '../../../components/Header';
import endFetch from '../../../axios';
import { useState, useEffect } from 'react';
import { Link, useParams } from 'react-router-dom';
import Voltar from '../../../components/Voltar';

export default function VisualizarAnimachado() {
    const { id } = useParams();
    const [animachado, setAnimachado] = useState({
        id: '',
        nome: '',
        especie: '',
        idade: '',
        status: '',
        historia: '',
        imagem: '',
        proteseEntity: null, // objeto da prótese
    });
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');

    const getAnimachado = async () => {
        try {
            const response = await endFetch.get(`/animachado/${id}`);
            const data = response.data;

            // Ajustar imagem base64 e proteseEntity
            const imagem = data.imagem
                ? `data:image/jpeg;base64,${data.imagem}`
                : '';

            setAnimachado({
                id: data.id,
                nome: data.nome,
                especie: data.especie,
                idade: data.idade,
                status: data.status,
                historia: data.historia,
                imagem,
                proteseEntity: data.proteseEntity || null,
            });

            setLoading(false);
        } catch (error) {
            setLoading(false);
            setError('Erro ao carregar os dados do Animachado');
            console.log(error.response ? error.response.data : error);
        }
    };

    useEffect(() => {
        getAnimachado();
    }, [id]);

    if (loading) {
        return <div>Carregando...</div>;
    }

    if (error) {
        return <div className={styles.erro}>{error}</div>;
    }

    return (
        <>
            <Header />
            <div className={styles.vizualizar}>
                <div className={styles.voltar}>
                        <Voltar />
                </div>
                <h1 className={styles.titulo}>Ficha do Animachado</h1>

                <div className={styles.card}>
                    <div className={styles.imagem}>
                        {/* Exibe imagem do animal */}
                        {animachado.imagem ? (
                            <img
                                src={animachado.imagem}
                                alt={animachado.nome}
                                className={styles.imagemAchado}
                            />
                        ) : (
                            <p>Sem imagem</p>
                        )}
                        <p className={styles.nome}>{animachado.nome}</p>
                    </div>

                    <div className={styles.informacoes}>
                        {/* Dados principais */}
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

                        {/* Informações da prótese */}
                        <div className={styles.dados}>
                            <p className={styles.caracteristica}>Prótese</p>
                            <div className={styles.animachado}>
                                {animachado.proteseEntity ? (
                                    <>  
                                        <p><strong>Nome:</strong> {animachado.proteseEntity.nome}</p>
                                        <p><strong>Custo:</strong> R$ {animachado.proteseEntity.custo}</p>
                                    </>
                                ) : (
                                    <p>Sem prótese associada</p>
                                )}
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
