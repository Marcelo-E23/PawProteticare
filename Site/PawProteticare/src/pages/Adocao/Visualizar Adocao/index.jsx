import styles from './visualizar.module.css';
import Header from '../../../components/Header';
import endFetch from '../../../axios';
import { useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import { useEffect } from 'react';
import voltar from '../../../components/Voltar';

export default function VisualizarAdocao(){
    const { id } = useParams();
    const [doacao, setDoacao] = useState({
        pro: '',
        especie: '',
        idade: '',
        status: '',
        historia:'',
        protese:'',
        imagem:'',
    });
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');

    const getAnimachado = async () => {
        try {
            const response = await endFetch.get(`/doacao/${id}`);
            setDoacao(response.data);
            setLoading(false);
        } catch (error) {
            setLoading(false);
            setError('Erro ao carregar os dados solicitação de adoção');
            console.log(error);
        }
    };

    useEffect(() => {
        getAdocao();
    }, [id]);

    if (loading) {
        return <div>Carregando...</div>;
    }

    return(
        <>        
        <Header/>
        <div className={styles.vizualizar}>
            
            <Link to={'/adocao'}><p className={styles.voltar}>Voltar</p></Link>
            <h1 className={styles.titulo}>Ficha animachado</h1>
                <div className={styles.informacoes}>
                    
                    <div className={styles.dados}>
                        <p className={styles.caracteristica}>ID do animachado</p>
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
                        <p className={styles.caracteristica}>Necessidade de Protése</p>
                        <div className={styles.animachado}>
                            <p>{animachado.protese}</p>
                        </div>
                    </div>

                    <div className={styles.dados}>
                        <p className={styles.caracteristica}>Historia</p>
                        <div className={styles.animachado}>
                            <p>{animachado.historia}</p>
                        </div>
                    </div>

                </div>
            </div>
        </>

    )
}