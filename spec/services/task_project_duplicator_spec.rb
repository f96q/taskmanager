require 'rails_helper'

RSpec.describe TaskProjectDuplicator, :type => :service do
  let(:user) { create :user }
  let(:template_project) { create :template_project, user: user }
  let!(:task) { create :task, project: template_project }
  let(:params) { ActionController::Parameters.new task_project: {title: 'duplicate'} }

  it 'should duplicate task project' do
    task_project = TaskProjectDuplicator.execute template_project, params
    task_project.user = user
    task_project.save
    expect(task_project.title).to eq('duplicate')
    task = task_project.tasks.first
    expect(task.task_type).to eq('feature')
    expect(task.status).to eq('unstarted')
    expect(task.point).to eq(0)
    expect(task.title).to eq('title1')
    expect(task.description).to eq('description')
  end
end
