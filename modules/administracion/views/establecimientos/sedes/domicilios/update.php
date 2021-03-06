<?php

use yii\helpers\Html;

/**
 * @var yii\web\View $this
 * @var app\models\SedeDomicilio $model
 */

$this->title = $model->direccion;

echo $this->render('_breadcrumbs', ['sede' => $model->sede]);
$this->params['breadcrumbs'][] = ['label' => $model->direccion, 'url' => ['establecimientos/' . $model->sede->establecimiento_id . '/sedes/' . $model->sede->id . '/domicilios/view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = Yii::t('app', 'Update');
?>
<div class="sede-domicilio-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('../_sede', ['sede' => $model->sede]) ?>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
