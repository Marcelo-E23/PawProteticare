import styles from './visualizar.module.css';
import Header from '../../../components/Header';
import endFetch from '../../../axios';
import { useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import { useEffect } from 'react';
import Voltar from '../../../components/Voltar';

export default function VisualizarProtese(){
    const { id } = useParams();
    const [protese, setProtese] = useState({
        nome: '',
        fabricante: '',
        custo: '',
        tipo: '',
        descricao:'',
    });
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');

    const getProtese = async () => {
        try {
            const response = await endFetch.get(`/protese/${id}`);
            setProtese(response.data);
            setLoading(false);
        } catch (error) {
            setLoading(false);
            setError('Erro ao carregar os dados do animadotado');
            console.log(error);
        }
    };

    useEffect(() => {
        getProtese();
    }, [id]);

    if (loading) {
        return <div>Carregando...</div>;
    }

    return(
        <>        
        <Header/>
        <div className={styles.vizualizar}>
            
            <Link to={'/Protese'}><p className={styles.voltar}>Voltar</p></Link>
            <h1 className={styles.titulo}>Ficha Protese</h1>

            <div className={styles.card}>
                <div className={styles.informacoes}>
                    
                    <div className={styles.dados}>
                        <p className={styles.caracteristica}>ID do animadotado</p>
                        <div className={styles.animadotado}>
                            <p>{protese.id}</p>
                        </div>
                    </div>
                    
                    <div className={styles.dados}>
                        <p className={styles.caracteristica}>Espécie</p>
                        <div className={styles.protese}>
                            <p>{protese.especie}</p>
                        </div>
                    </div>

                    <div className={styles.dados}>
                        <p className={styles.caracteristica}>Idade</p>
                        <div className={styles.protese}>
                            <p>{protese.idade}</p>
                        </div>
                    </div>

                    <div className={styles.dados}>
                        <p className={styles.caracteristica}>Status</p>
                        <div className={styles.protese}>
                            <p>{protese.status}</p>
                        </div>
                    </div>

                    <div className={styles.dados}>
                        <p className={styles.caracteristica}>Necessidade de Protése</p>
                        <div className={styles.protese}>
                            <p>{protese.protese}</p>
                        </div>
                    </div>

                    <div className={styles.dados}>
                        <p className={styles.caracteristica}>Historia</p>
                        <div className={styles.protese}>
                            <p>{protese.historia}</p>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        </>

    )
}