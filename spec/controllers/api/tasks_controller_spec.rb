require 'rails_helper'

RSpec.describe Api::TasksController, :type => :controller do
  let!(:user) { create :user }

  describe '#index' do
    render_views
    before { sign_in user }
    let!(:task) { create :task, user: user }

    it 'should get tasks' do
      get :index, format: [:json]
      tasks = JSON.parse response.body
      task = tasks.first
      expect(task['task_type']).to eq('feature')
      expect(task['status']).to eq('unstarted')
      expect(task['point']).to eq(0)
      expect(task['title']).to eq('title1')
      expect(task['description']).to eq('description')
    end
  end

  describe '#create' do
    before { sign_in user }

    it 'should create task' do
      expect {
        post :create, task: {uuid: SecureRandom.uuid, task_type: 'feature', status: 'unstarted', point: 0, title: 'title1', description: 'description'}
      }.to change { Task.count }.from(0).to(1)
    end
  end

  describe '#update' do
    let(:task) { create :task, user: user }

    before { sign_in user }

    it 'should update task' do
      put :update, id: task.uuid, task: {task_type: 'release', status: 'finished', point: 3, title: 'update title', description: 'update description'}
      task.reload
      expect(task.task_type).to eq('release')
      expect(task.status).to eq('finished')
      expect(task.point).to eq(3)
      expect(task.title).to eq('update title')
      expect(task.description).to eq('update description')
    end
  end

  describe '#destroy' do
    let!(:task) { create :task, user: user }

    before { sign_in user }

    it 'should destroy task' do
      expect {
        delete :destroy, id: task.uuid
      }.to change { Task.count }.from(1).to(0)
    end
  end
end
