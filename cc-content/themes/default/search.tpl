<h1><?=Language::GetText('search_header')?></h1>

<p><strong><?=Language::GetText('results_for')?>: '<em><?=$cleaned?></em>'</strong></p>

<?php if (!empty ($search_videos)): ?>
    <div class="videos_list">
    <?php foreach ($search_videos as $video): ?>
        <div class="video">
            <div class="thumbnail">
                <a href="<?=$this->getService('Video')->getUrl($video)?>/" title="<?=$video->title?>">
                    <img width="165" height="92" src="<?=$config->thumb_url?>/<?=$video->filename?>.jpg" />
                </a>
                <?php $playlistId = ($loggedInUser) ? $this->getService('Playlist')->getUserSpecialPlaylist($loggedInUser, 'watch_later')->playlistId : ''; ?>
                <span class="watchLater"><a data-video="<?=$video->videoId?>" data-playlist="<?=$playlistId?>" href="" title="<?=Language::GetText('watch_later')?>"><?=Language::GetText('watch_later')?></a></span>
                <span class="duration"><?=$video->duration?></span>
            </div>
            <div>
                <p class="big"><a href="<?=$this->getService('Video')->getUrl($video)?>/" title="<?=$video->title?>"><?=$video->title?></a></p>
                <p class="small">
                    <strong><?=Language::GetText('by')?>:</strong> <a href="<?=HOST?>/members/<?=$video->username?>/" title="<?=$video->username?>"><?=$video->username?></a>,
                    <strong><?=Language::GetText('views')?>:</strong> <?=$video->views?>
                </p>
                <p><?=Functions::CutOff($video->description, 300)?></p>
            </div>
        </div>
    <?php endforeach; ?>
    </div>
    <?=$pagination->Paginate()?>
<?php else: ?>
    <p><strong><?=Language::GetText('no_results')?></strong></p>
<?php endif; ?>