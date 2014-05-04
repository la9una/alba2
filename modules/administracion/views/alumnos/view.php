<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/**
 * @var yii\web\View $this
 * @var app\models\Persona $model
 */

$this->title = $model->apellido . ', ' . $model->nombre;
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Administración'), 'url' => ['default/index']];
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Alumnos'), 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="persona-view">

    <h1><?= Html::encode($this->title) ?> <small><?= $model->documentoCompleto ?></small></h1>

    <p>
        <?= Html::a(Yii::t('app', 'Update'), ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a(Yii::t('app', 'Delete'), ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => Yii::t('app', 'Are you sure you want to delete this item?'),
                'method' => 'post',
            ],
        ]) ?>
    </p>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
            'apellido',
            'nombre',
            'fecha_alta',
            'tipo_documento_id',
            'numero_documento',
            'estado_documento_id',
            'sexo_id',
            'fecha_nacimiento',
            'lugar_nacimiento',
            'telefono',
            'telefono_alternativo',
            'email:email',
            'foto',
            'observaciones',
        ],
    ]) ?>

</div>
