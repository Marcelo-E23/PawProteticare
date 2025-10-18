import { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import Header from '../../../components/Header';
import Voltar from '../../../components/Voltar';
import endFetch from '../../../axios';
import styles from './visualizar.module.css';

export default function VisualizarProtese() {
    const { id } = useParams();
    const [protese, setProtese] = useState({});
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchProtese = async () => {
            try {
                const response = await endFetch.get(`/protese/${id}`);
                setProtese(response.data);
            } catch (error) {
                console.error(error);
            } finally {
                setLoading(false);
            }
        };
        fetchProtese();
    }, [id]);

    if (loading) return <div>Carregando...</div>;

    return (
        <>
            <Header />
            <div className={styles.vizualizar}>
                <Link to={'/Protese'}><p className={styles.voltar}>Voltar</p></Link>
                <h1 className={styles.titulo}>Ficha da Prótese</h1>

                <div className={styles.card}>
                    <div className={styles.informacoes}>
                        <p><strong>ID da Prótese:</strong> {protese.id}</p>
                        <p><strong>Nome:</strong> {protese.nome}</p>
                        <p><strong>Fabricante:</strong> {protese.fabricante}</p>
                        <p><strong>Custo:</strong> {protese.custo}</p>
                        <p><strong>Tipo:</strong> {protese.tipo}</p>
                        <p><strong>Descrição:</strong> {protese.descricao}</p>
                        <p>
                            <strong>ID do Animal:</strong> 
                            <Link to={`/VisualizarAnimalAdotado/${protese.animalId}`}> {protese.animalId}</Link>
                        </p>
                    </div>
                </div>
            </div>
        </>
    );
}
