import styles from './visualizar.module.css';
import Header from '../../../components/Header';
import endFetch from '../../../axios';
import { useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import { useEffect } from 'react';
import Voltar from '../../../components/Voltar';

export default function VisualizarAnimadotado(){
    const { id } = useParams();
    const [animadotado, setAnimadotado] = useState({
        nome: '',
        especie: '',
        idade: '',
        status: '',
        historia:'',
        protese:'',
        imagem:'',
    });
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');

    const getAnimadotado = async () => {
        try {
            const response = await endFetch.get(`/animadotado/${id}`);
            setAnimadotado(response.data);
            setLoading(false);
        } catch (error) {
            setLoading(false);
            setError('Erro ao carregar os dados do animadotado');
            console.log(error);
        }
    };

    useEffect(() => {
        getAnimadotado();
    }, [id]);

    if (loading) {
        return <div>Carregando...</div>;
    }

    return(
        <>        
        <Header/>
        <div className={styles.vizualizar}>
            
            <Link to={'/AnimalAdotado'}><p className={styles.voltar}>Voltar</p></Link>
            <h1 className={styles.titulo}>Ficha animadotado</h1>

            <div className={styles.card}>
                <div className={styles.imagem}>
                    <img src={animadotado.imagem} alt={animadotado.nome} />
                    <p>{animadotado.nome}</p>
                </div>

                <div className={styles.informacoes}>
                    
                    <div className={styles.dados}>
                        <p className={styles.caracteristica}>ID do animadotado</p>
                        <div className={styles.animadotado}>
                            <p>{animadotado.id}</p>
                        </div>
                    </div>
                    
                    <div className={styles.dados}>
                        <p className={styles.caracteristica}>Espécie</p>
                        <div className={styles.animadotado}>
                            <p>{animadotado.especie}</p>
                        </div>
                    </div>

                    <div className={styles.dados}>
                        <p className={styles.caracteristica}>Idade</p>
                        <div className={styles.animadotado}>
                            <p>{animadotado.idade}</p>
                        </div>
                    </div>

                    <div className={styles.dados}>
                        <p className={styles.caracteristica}>Status</p>
                        <div className={styles.animadotado}>
                            <p>{animadotado.status}</p>
                        </div>
                    </div>

                    <div className={styles.dados}>
                        <p className={styles.caracteristica}>Necessidade de Protése</p>
                        <div className={styles.animadotado}>
                            <p>{animadotado.protese}</p>
                        </div>
                    </div>

                    <div className={styles.dados}>
                        <p className={styles.caracteristica}>Historia</p>
                        <div className={styles.animadotado}>
                            <p>{animadotado.historia}</p>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        </>

    )
}