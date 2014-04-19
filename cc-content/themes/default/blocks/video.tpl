<?php $video = $model ?>

<div class="video">
    <div class="thumbnail">
        <a href="<?=$this->getService('Video')->getUrl($video)?>/" title="<?=$video->title?>">
            <img width="165" height="92" src="<?=$config->thumb_url?>/<?=$video->filename?>.jpg" />
        </a>
        <?php $playlistId = ($loggedInUser) ? $this->getService('Playlist')->getUserSpecialPlaylist($loggedInUser, 'watch_later')->playlistId : ''; ?>
        <span class="watchLater"><a data-video="<?=$video->videoId?>" data-playlist="<?=$playlistId?>" href="" title="<?=Language::GetText('watch_later')?>"><?=Language::GetText('watch_later')?></a></span>
        <span class="duration"><?=$video->duration?></span>
    </div>
    <p><a href="<?=VideoService::getUrl($video)?>/" title="<?=$video->title?>"><?=$video->title?></a></p>
</div>