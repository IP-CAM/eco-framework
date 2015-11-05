<?php echo $header; ?><?php echo $column_left; ?>
<?php  $token_random = rand();  ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-html" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
		<a id="button-send"  class="btn btn-default" onclick="send('index.php?route=module/newslettersubscribe/send&token=<?php echo $token; ?>');" class="button"><?php echo $button_send; ?></a>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
		</div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo 'Edit Form'; ?></h3>
      </div>
      <div class="panel-body">
	  
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-html" class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
							<div class="col-sm-10">
							  <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
							  <?php if ($error_name) { ?>
							  <div class="text-danger"><?php echo $error_name; ?></div>
							  <?php } ?>
							</div>
						  </div>
				     <div class="form-group">
						<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
						<div class="col-sm-10">
						  <select name="status" id="input-status" class="form-control">
							<?php if ($status) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div> 
					   
					  
			   <div class="row">
						 <div class="tab-pane" id="tab-module">
							  <ul class="nav nav-tabs" id="module" data-tabs="module">
									<li>
										<a href="#tab-general" class="selected"  data-toggle="tab" ><?php echo $tab_general; ?></a>
									</li>
									<li>
										<a href="#tab-list"  class="" data-toggle="tab" ><?php echo $tab_list; ?></a>
									</li>
							  </ul>
						  </div>
						   <div class="tab-content">
								<div class="tab-pane" id ="tab-general">
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-name"><?php echo $entry_unsubscribe; ?></label>
											 <div class="col-sm-10">
											  <select class="form-control" name="newslettersubscribe_unsubscribe">
												  <?php if ($newslettersubscribe_unsubscribe) { ?>
												  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
												  <option value="0"><?php echo $text_disabled; ?></option>
												  <?php } else { ?>
												  <option value="1"><?php echo $text_enabled; ?></option>
												  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
												  <?php } ?>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-name"><?php echo $entry_enable_popup; ?></label>
											<div class="col-sm-10">
												<select class="form-control" name="newslettersubscribe_popup">
													<?php if ($newslettersubscribe_popup) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-name"><?php echo $mail_description; ?></label>
											<div class="col-sm-10">
												<input type="text" class="form-control" name="newslettersubscribe_mail_description" value="<?php echo $newslettersubscribe_mail_description; ?>" >
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-name"><?php echo $entry_mail; ?></label>
											 <div class="col-sm-10">
											  <select class="form-control" name="newslettersubscribe_mail_status">
												  <?php if ($newslettersubscribe_mail_status) { ?>
												  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
												  <option value="0"><?php echo $text_disabled; ?></option>
												  <?php } else { ?>
												  <option value="1"><?php echo $text_enabled; ?></option>
												  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
												  <?php } ?>
												</select>
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-name"><?php echo $entry_thickbox; ?></label>
											 <div class="col-sm-10">
											  <select class="form-control" name="newslettersubscribe_thickbox">
												  <?php if ($newslettersubscribe_thickbox) { ?>
												  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
												  <option value="0"><?php echo $text_disabled; ?></option>
												  <?php } else { ?>
												  <option value="1"><?php echo $text_enabled; ?></option>
												  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
												  <?php } ?>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-name"><?php echo $entry_registered; ?></label>
											 <div class="col-sm-10">
											 <select class="form-control" name="newslettersubscribe_registered">
											  <?php if ($newslettersubscribe_registered) { ?>
											  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
											  <option value="0"><?php echo $text_disabled; ?></option>
											  <?php } else { ?>
											  <option value="1"><?php echo $text_enabled; ?></option>
											  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
											  <?php } ?>
											</select>
											</div>
										</div>
				
								</div>
								<div class="tab-pane" id ="tab-list">
									<div class="table-responsive">
									<table class="table table-bordered table-hover">
										<thead>
											<thead>
												<tr>
													<td class="left"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
													<td class="left">No</td>
													<td class="left">Email</td>
													<td class="left">Name</td>
													<td class="right">Action</td>
												</tr>
											</thead>
											<tbody>
												<?php if($users) { ?>
												<?php foreach ($users as $key => $user) { ?>
												<tr>
													<td class="left">
														<?php if ($user['selected']) { ?>
														<input type="checkbox" name="selected[]" value="<?php echo $user['id']; ?>" checked="checked" />
														<?php } else { ?>
														<input type="checkbox" name="selected[]" value="<?php echo $user['id']; ?>" />
														<?php } ?>
													</td>
													<td class="left"><?php echo $page_nav+$key+1; ?></td>
													<td class="left"><?php echo $user['email_id']; ?></td>
													<td class="left"><?php echo $user['name']; ?></td>
													<td class="right">
													<?php foreach ($user['action'] as $action) { ?>
													[ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
													<?php } ?>
													</td>
												</tr>
												<?php } ?>
												<?php } else { ?>
												<tr>
												  <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
												</tr>
												<?php } ?>
											</tbody>
									</table>
									<div class="pagination"><?php echo $pagination; ?></div>
									</div>
								</div>
						   </div>
						
			   </div>
			  
        </form>
		
      </div>
    </div>
  </div>
 </div>
<script  type ="text/javascript">
	$('#module li:first-child a').tab('show');
	$('#input-description').summernote({
		height: 300
	});
</script> 

  
<?php echo $footer; ?>
